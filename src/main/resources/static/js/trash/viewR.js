let edit =  document.querySelector(".edit-button");

edit.addEventListener("click",function(e){
    if(edit.innerHTML==="수정"){
        document.querySelector("#reviseReply").disabled=false;
        edit.innerHTML="수정완료";
        e.preventDefault();
    }else if(edit.innerHTML==="수정완료"){
		e.preventDefault();
        var comments = document.querySelector("#reviseReply")
        comments.disabled=true;
        //var form = document.querySelector("#existReply");
        var boardid =  document.querySelector("#boardid");
        var replyid = document.querySelector("#replyid");
       	alert("수정이 완료되었습니다.");
        location.href = '/myProject/ReviseDeleteReply.do?comment='+comments.value+'&boardid='+boardid.value+"&replyid="+replyid.value+'&submitValue='+edit.value;
        

    }

})