let list = document.querySelector("#goList");

list.addEventListener("click",function(){
	var link =list.value;
	console.log(link)
	location.href="/myProject/"+link;
});
