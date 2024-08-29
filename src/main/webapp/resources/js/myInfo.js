function reg_type_select(type) {
	// 모든 섹션을 숨기기
	document.querySelector('.type_1').style.display = 'none';
	document.querySelector('.type_2').style.display = 'none';
	document.querySelector('.type_3').style.display = 'none';
	

	// 모든 링크에서 active 클래스를 제거
    document.querySelectorAll('.menu_left a').forEach(function(link) { 
    	link.classList.remove('active'); 
	});
	
	// 선택된 타입에 따라 해당 섹션을 표시
	if (type === '1') {
		document.querySelector('.type_1').style.display = 'block';
		document.getElementById('profile-link').classList.add('active');
	} else if (type === '2') {
		document.querySelector('.type_2').style.display = 'block';
		document.getElementById('info-link').classList.add('active');
	} else if (type === '3') {
		document.querySelector('.type_3').style.display = 'block';
		document.getElementById('password-link').classList.add('active');
	}
}


//주소검색
function sample4_execDaumPostcode() {
	new daum.Postcode({
		oncomplete : function(data) {
			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

			// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			var roadAddr = data.roadAddress; // 도로명 주소 변수
			var extraRoadAddr = ''; // 참고 항목 변수

			// 법정동명이 있을 경우 추가한다. (법정리는 제외)
			// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
			if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
				extraRoadAddr += data.bname;
			}
			// 주소 정보를 해당 필드에 넣는다.
			document.getElementById("u_address").value = roadAddr;

		}
	}).open();
}

function validateField(fieldName) {
	let isValid = true;

	// 필드와 값 가져오기
	const field = document.forms["passwordForm"][fieldName];
	const value = field.value;
	const errorSpan = document.getElementById(fieldName + '-error');

	// 패턴 정의
	const pwPattern = /^(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[\W_]).{8,20}$/;
	
	// 필드 이름에 따라 필드 값 검사
	if (fieldName === 'u_pw') {
		if (!pwPattern.test(value)) {
			errorSpan.textContent = "비밀번호는 8~20자의 영문, 숫자, 특수문자를 사용해야 합니다.";
			errorSpan.style.color = "red";
			isValid = false;
		} else {
			errorSpan.textContent = '';
		}
	}

	if (fieldName === 'u_pw_check') {
		const pw = document.forms["passwordForm"]["u_pw"].value;
		if (value !== pw) {
			errorSpan.textContent = "비밀번호와 비밀번호 확인이 일치하지 않습니다.";
			errorSpan.style.color = "red";
			errorSpan.classList.remove('correct-message');
			errorSpan.classList.add('error-message');
			isValid = false;
		} else {
			errorSpan.textContent = "비밀번호가 일치합니다.";
			errorSpan.style.margin = "10px 30px";
			errorSpan.style.color = "green";
			errorSpan.classList.remove('error-message');
			errorSpan.classList.add('correct-message');
		}
	}
	
	return isValid;
}

function validateForm() {
	let isValid = true;

	// 각 필드 검사
	const fields = ['u_pw', 'u_pw_check'];
	fields.forEach(function(fieldName) {
		if (!validateField(fieldName)) {
			isValid = false;
		}
	});

	return isValid;
}

//비밀번호 가리기/보기 기능
function togglePassword(fieldId, buttonId) {
    const passwordField = document.getElementById(fieldId);
    const toggleImg = document.getElementById('toggleImg');
    /*const contextPath = '${pageContext.request.contextPath}';*/
    
    if (passwordField.type === "password") {
        passwordField.type = "text";
        toggleImg.src = contextPath + "/resources/img/close.png"; // 비밀번호가 보일 때 이미지
        toggleImg.alt = "가리기";
    } else {
        passwordField.type = "password";
        toggleImg.src = contextPath + "/resources/img/open.png"; // 비밀번호가 가려질 때 이미지
        toggleImg.alt = "보기";
    }
}

function confirmDelete() {
	// 확인 및 취소 버튼이 있는 메시지 표시
	var confirmed = confirm("정말로 회원 탈퇴하시겠습니까? 회원탈퇴 취소");

	// 사용자가 '확인'을 클릭한 경우
	if (confirmed) {
		// 페이지 이동
		location.href = '/ex/user/deactivateDB';
	}
	// 사용자가 '취소'를 클릭하면 아무 작업도 하지 않음
}