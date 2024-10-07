/**
 * 
 */  
let lastId = null;

function toggleAnswer(id) {
    var currentA = document.getElementById('answer-' + id);
    
    if (lastId !== null && lastId !== id) {
        var lastA = document.getElementById('answer-' + lastId);
        lastA.style.display = 'none';
        var lastQ = document.getElementById('question-' + lastId);
        lastQ.classList.remove('question-active');
    }
    
    if (currentA.style.display === 'none' || currentA.style.display === '') {
        currentA.style.display = 'block';
        var currentQ = document.getElementById('question-' + id);
        currentQ.classList.add('question-active');
    } else {
        currentA.style.display = 'none';
        var currentQ = document.getElementById('question-' + id);
        currentQ.classList.remove('question-active');
    }
    
    lastId = (currentA.style.display === 'block') ? id : null;
}
	
function toggleChatbot() {
    var chatbot = document.getElementById('chatbot');
    chatbot.style.display = (chatbot.style.display === 'none' || chatbot.style.display === '') ? 'block' : 'none';
}

function moveKakao() {
	window.open("http://pf.kakao.com/_GxoJZn","_blank",'width=600,height=800');
}