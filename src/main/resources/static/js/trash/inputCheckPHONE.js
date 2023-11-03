//전화번호 유효성검사
var phone = document.getElementById("phone");

phone.addEventListener("input", function() {
  var value = this.value;
  var sanitizedValue = sanitizePhoneNumber(value);

  this.value = sanitizedValue;
});

function sanitizePhoneNumber(value) {
  var sanitizedValue = value.replace(/[^0-9]/g, ""); // 숫자 이외의 문자 제거

  var formattedValue = '';
  var chunkLengths = [3, 4, 4]; // 각 청크(3, 4, 4)의 길이 설정

  var index = 0;
  for (var i = 0; i < chunkLengths.length; i++) {
    var chunk = sanitizedValue.slice(index, index + chunkLengths[i]);
    if (chunk.length > 0) {
      formattedValue += chunk;
      if (i < chunkLengths.length - 1) {
        formattedValue += '-';
      }
    }
    index += chunkLengths[i];
  }

  return formattedValue;
}