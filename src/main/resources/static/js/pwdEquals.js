
const insertPwd = () => {
	let pwd = document.querySelector("#insert-pwd")
	let pwd2 = document.querySelector("#insert-pwd2")
	
	if(pwd.value != pwd2.value){
		alert("비밀번호를 다시 확인해주세요");
        return false;
	}
}
const revisePwd = () => {
	let pwd = document.querySelector("#revise-pwd")
	let pwd2 = document.querySelector("#revise-pwd2")
	
	if(pwd.value != pwd2.value){
		alert("비밀번호를 다시 확인해주세요");
        return false;
	}
}

