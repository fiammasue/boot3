//비밀번호 유효성검사
var pwd1 = document.querySelector("#pwd");
var errorMessage = document.querySelector("#pwdErrorMessage");

pwd1.addEventListener("input", function() {
  var value = this.value;
  var regex = /^[a-zA-Z0-9!@]*$/; // 숫자, 영문, 특수문자('!', '@')만 허용하는 정규식

  if (!regex.test(value)) {
    errorMessage.textContent = "숫자, 영문, '!', '@'만 입력할 수 있습니다.";
  } else {
    errorMessage.textContent = "";
  }
});