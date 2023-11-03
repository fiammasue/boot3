//이름 유효성 검사
var name1 = document.querySelector("#name");

name1.addEventListener("input", function() {
  var value = this.value;
  var regex = /^[a-zA-Zㄱ-ㅎ가-힣]*$/; // 영문과 한글만을 허용하는 정규식
  
  if (!regex.test(value)) {
    this.value = value.replace(/[^a-zA-Zㄱ-ㅎ가-힣]/g, ""); // 영문과 한글 이외의 문자 제거
    alert("영문과 한글만 입력할 수 있습니다.");
  }
});