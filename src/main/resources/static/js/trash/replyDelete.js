let delete_button =  document.querySelector(".delete-button");

delete_button.addEventListener("click",function(e) {
	const flag = confirm("정말로 삭제하시겠습니까?");
    if (flag) {
      var form = document.querySelector("#existReply");
      form.submit();
    }else{
		e.preventDefault();
	}
});