function showSection(sectionId, clickedElement) {
        // 모든 섹션 숨기기
        document.getElementById('myPosts').style.display = 'none';
        document.getElementById('myComments').style.display = 'none';
        
        // 모든 탭 비활성화
        var tabs = document.querySelectorAll('.board-typeItem');
        tabs.forEach(function(tab) {
            tab.classList.remove('active');
        });

        // 선택된 섹션 보이기
        document.getElementById(sectionId).style.display = 'block';
        
        // 클릭된 탭 활성화
        clickedElement.classList.add('active');
    }

    window.onload = function() {
        var defaultTab = document.querySelector('.board-typeItem');
        showSection('myPosts', defaultTab);
    }
    $(function(){
        var chkObj = document.getElementsByName("b_id");
        var rowCnt = chkObj.length;

        // 전체 선택 체크박스 클릭 이벤트
        $("input[name='allCheck']").click(function(){
            var chk_listArr = $("input[name='b_id']");
            for (var i=0; i<chk_listArr.length; i++){
                chk_listArr[i].checked = this.checked;
            }
        });

        // 각각의 체크박스 클릭 이벤트
        $("input[name='b_id']").click(function(){
            if($("input[name='b_id']:checked").length == rowCnt){
                $("input[name='allCheck']")[0].checked = true;
            } else {
                $("input[name='allCheck']")[0].checked = false;
            }
        });
    });

 // 선택 삭제 폼 제출 함수
    function submitDeleteForm() {
        var url = "/ex/user/deleteMyBoard"; // 전송할 URL
        var valueArr = [];

        // 체크된 게시글 ID 수집
        $("input[name='b_id']:checked").each(function() {
            valueArr.push(this.value);
        });

        if (valueArr.length === 0) {
            alert("선택된 글이 없습니다.");
        } else {
            var chk = confirm("정말 삭제하시겠습니까?");
            if (chk) { // 확인을 눌렀을 경우
                $.ajax({
                    url: url,
                    type: 'POST',
                    traditional: true,
                    data: {
                        b_ids: valueArr // 배열로 체크된 게시글 ID 전송
                    },
                    success: function(response) {
                        if (response > 0) { // 삭제된 게시물 수가 0보다 클 경우
                            alert(response + "개의 게시물이 삭제되었습니다.");
                            // 삭제된 게시물 DOM에서 제거
                            $("input[name='b_id']:checked").each(function() {
                                $(this).closest('.board-item').remove(); // 체크된 게시물의 DOM 요소 제거
                            });
                        } else {
                            alert("삭제 실패");
                        }
                    },
                    error: function() {
                        alert("서버와의 통신에 문제가 발생했습니다.");
                    }
                });
            }
        }
    }

    // 모두 선택 또는 선택 해제 함수
    function selectAllCheckboxes(select) {
        $("input[name='b_id']").prop("checked", select);
    }
