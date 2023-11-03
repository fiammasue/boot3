//아이디 유효성검사
var uid = document.querySelector("#uid");

uid.addEventListener("input", function() {
  var value = this.value;
  var regex = /^[a-zA-Z0-9]*$/; // 영문과 숫자만을 허용하는 정규식
  
  if (!regex.test(value)) {
    this.value = value.replace(/[^a-zA-Z0-9]/g, ""); // 영문과 숫자 이외의 문자 제거
    alert("영문과 숫자만 입력할 수 있습니다.");
  }
});