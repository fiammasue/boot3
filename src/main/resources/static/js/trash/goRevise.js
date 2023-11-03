let revise_go = document.querySelector("#goRevise");

revise_go.addEventListener("click",function(){
	var link =revise_go.value;
	console.log(link)
	location.href="<c:url value='/board/"+link+"'/>";
});