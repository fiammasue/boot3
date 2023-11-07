/**
 * 
 */
$(function(){
	
	
	
	
	
	//필수 체크 영역을 체크 하였는지 확인한다.
	  // 2.이용약관하나라도 안누르면 다음버튼안눌리게 return false
	function chBox(){
		let chkBox = document.querySelectorAll(".button");
        // 필수 선택요소가 선택이 되지 않으면 href로 안넘어감
        if(!chkBox[0].checked || !chkBox[1].checked){
            alert("필수 선택 요소를 선택해주세요");

        }else{
        	insertAgree.dialog("close");
        	insertForm.dialog("open");
        }
	}
	//아이디 중복값 확인
	let existUidChecked = false;
	function existUid(){
	    const param = {
	    		uid: $('#insert-uid').val()
	    		};

	    
	    $.ajax({
	    	url:isExistUid ,
	    	type:"POST",
	    	contentType: "application/json; charset=UTF-8",
	    	data:JSON.stringify(param),
	    	dataType:"json",
	    	success:function(json){
	    		alert(json.message);
	    		if (json.status) {
	 	      	   uid.val("");
	 	      	   uid.focus();
	 	  	       existUidChecked = false;
	 	       } else {
	 	    	   existUidChecked = true;
	 	       }
	    	}
	    }); 
//	    fetch("/legacy/member/isExistUid.do", {
//	      method: "POST",
//	      headers: {
//	        "Content-Type": "application/json; charset=UTF-8",
//	      },
//	      body: JSON.stringify(param),
//	    })
//	    .then((response) => response.json())
//	    .then((json) => {
//	       alert(json.message);
//	       if (json.status) {
//	      	   uid.value = "";
//	      	   uid.focus();
//	  	       existUidChecked = false;
//	       } else {
//	    	   existUidChecked = true;
//	       }
//	    });
	}
	//회원가입 ajax
	function insertMember(){
		if (!existUidChecked) {
			alert("아이디 중복을 확인 해주세요");
			existUid.focus();
			return;
		}
	    const param = {
		        uid: $('#insert-uid').val(),
		        pwd: $('#insert-pwd').val(),
		        name: $('#insert-uname').val(),
		        phone: $('#insert-phone').val(),
		        address : $('#insert-address').val(),
		        gender : document.querySelector('input[name="gender"]:checked').value,
		        age: $('#insert-age').val(),
		        email : $('#insert-email').val()	
		        
		      };
	    
		$.ajax({
	    	url:InsertMember ,
	    	type:"POST",
	    	contentType: "application/json; charset=UTF-8",
	    	data:JSON.stringify(param),
	    	dataType:"json",
	    	success:function(json){
	    		alert(json.message);
		          if (json.status) {
		        	  insertForm.dialog("close");
		          }
	    	}
	    }); 
	}
	//웹소켓 연결
	//const sock = new SockJS("/ws-stomp");
	//const ws = Stomp.over(sock);
	//var subscription=null;
	//var sender = localStorage.getItem('chat.sender');;
	//console.log("sender ", sender)
	//로그인 ajax
	function login(){
		localStorage.setItem('chat.sender', sender);
		const param = {
		        username: username.value,
		        password: password.value
		      };
		 $.ajax({
		    	url:"/login.do",
		    	type:"POST",
		    	data:param,
		    	success:function(json){
					
		    		alert(json.message);
		    		if (json.status) {
			        	  location.href = Index; 
			          }
/*			          //채팅알람에 대한 구독중
			       ws.connect({},function(frame){
						subscription = ws.subscribe("/sub/chat/alarm/"+username.value
								,message => {//구독한곳에서 메시지가 오면
									const recv = JSON.parse(message.body);//메시지 파싱
									chatRecvMessage(recv);
								}, {sender:username.value});//보내는 사람을 등록할필요가 있나?
					},error => {
						alert("error "+error);
					}); //채팅 알람 */
		    	}
		    }); 
//		      fetch("/legacy/member/LoginMember.do", {
//		        method: "POST",
//		        headers: {
//		          "Content-Type": "application/json; charset=UTF-8",
//		        },
//		        body: JSON.stringify(param),
//		      })
//		      .then((response) => response.json())
//		      .then((json) => {
//		    	  alert(json.message);
//		          if (json.status) {
//		        	  location.href = "/legacy/main/Index.do"; 
//		          }
//		      });
	}
/*	function chatRecvMessage(recv) {
		alert(recv.contents);
	}*/
	//비밀번호 찾기 ajax
	function pwdFind(){
		 const param = {
	   		        uid: $('#pwd-uid').val(),
	   		        name: $('#pwd-uname').val(),
	   		        phone:$('#pwd-phone').val(),
	   		        pwd: $('#pwd-pwd').val()
	   		      };
		 $.ajax({
		    	url:PwdFind ,
		    	type:"POST",
		    	contentType: "application/json; charset=UTF-8",
		    	data:JSON.stringify(param),
		    	dataType:"json",
		    	success:function(json){
	   		    	  alert(json.message);
	   		    	pwdForm.dialog( "close" );
		    	}
		    }); 
//	   		      fetch("/legacy/member/PwdFind.do", {
//	   		        method: "POST",
//	   		        headers: {
//	   		          "Content-Type": "application/json; charset=UTF-8",
//	   		        },
//	   		        body: JSON.stringify(param),
//	   		      })
//	   		      .then((response) => response.json())
//	   		      .then((json) => {
//	   		    	  alert(json.message);
//	   		    	pwdForm.dialog( "close" );
//	   		      });
	}
	//아이디 찾기 ajax
	function uidFind(){
		const param = {
   		        name: $('#uid-uname').val(),
   		        phone:$('#uid-phone').val()
   		      };
		
	    $.ajax({
	    	url:UidFind,
	    	type:"POST",
	    	contentType: "application/json; charset=UTF-8",
	    	data:JSON.stringify(param),
	    	dataType:"json",
	    	success:function(json){
		    	  alert(json.message);
		    	uidForm.dialog( "close" );
	    	}
	    });

//   		      fetch("/legacy/member/UidFind.do", {
//   		        method: "POST",
//   		        headers: {
//   		          "Content-Type": "application/json; charset=UTF-8",
//   		        },
//   		        body: JSON.stringify(param),
//   		      })
//   		      .then((response) => response.json())
//   		      .then((json) => {
//   		    	  alert(json.message);
//   		    	uidForm.dialog( "close" );
//
//   		      });
	}
	//회원정보 수정 ajax
	function reviseMember(){
		 const param = {
	        		uid:$('#revise-uid').val(),
	    	        pwd: $('#revise-pwd').val(),
	    	        name: $('#revise-uname').val(),
	    	        phone: $('#revise-phone').val(),
	    	        address : $('#revise-address').val(),
	    	        gender : document.querySelector('input[name="revise-gender"]:checked').value,
	    	        age: $('#revise-age').val(),
	    	        email: $('#revise-email').val()
	    	      };
		    $.ajax({
		    	url:ReviseMember,
		    	type:"POST",
		    	contentType: "application/json; charset=UTF-8",
		    	data:JSON.stringify(param),
		    	dataType:"json",
		    	success:function(json){
	    	    	  alert(json.message);
	    	    	  $('#view-uid').text(json.loginMember.uid);
	    	    	  $('#view-pwd').text(json.loginMember.pwd);
	    	    	  $('#view-uname').text(json.loginMember.name);
	    	    	  $('#view-phone').text(json.loginMember.phone);
	    	    	  $('#view-address').text(json.loginMember.address);
	    	    	  $('#view-age').text(json.loginMember.age);
	    	    	  $('#view-email').text(json.loginMember.email);
	    	    	  $('#view-gender').text(json.loginMember.gender);
	    	    	  reviseForm.dialog( "close" );
		    	}
		    }); 
//	    	      fetch("/legacy/member/ReviseMember.do", {
//	    	        method: "POST",
//	    	        headers: {
//	    	          "Content-Type": "application/json; charset=UTF-8",
//	    	        },
//	    	        body: JSON.stringify(param),
//	    	      })
//	    	      .then((response) => response.json())
//	    	      .then((json) => {
//	    	    	  alert(json.message);
//	    	    	  $('#view-uid').text(json.loginMember.uid);
//	    	    	  $('#view-pwd').text(json.loginMember.pwd);
//	    	    	  $('#view-uname').text(json.loginMember.name);
//	    	    	  $('#view-phone').text(json.loginMember.phone);
//	    	    	  $('#view-address').text(json.loginMember.address);
//	    	    	  $('#view-age').text(json.loginMember.age);
//	    	    	  $('#view-email').text(json.loginMember.email);
//	    	    	  $('#view-gender').text(json.loginMember.gender);
//	    	    	  reviseForm.dialog( "close" );
//	    	         
//	    	      });
	}
	//회원정보 삭제 ajax
	function removeMember(){
		const param = {
   		        pwd: $('#remove-pwd').val()
   		      };
		
	    $.ajax({
	    	url:RemoveMember,
	    	type:"POST",
	    	contentType: "application/json; charset=UTF-8",
	    	data:JSON.stringify(param),
	    	dataType:"json",
	    	success:function(json){
		    	  alert(json.message);
		          if (json.status) {
		        	  removeForm.dialog( "close" );
		        	  location.href =Index; 
		          }
	    	}
	    }); 	

//   		      fetch("/legacy/member/RemoveMember.do", {
//   		        method: "POST",
//   		        headers: {
//   		          "Content-Type": "application/json; charset=UTF-8",
//   		        },
//   		        body: JSON.stringify(param),
//   		      })
//   		      .then((response) => response.json())
//   		      .then((json) => {
//   		    	  alert(json.message);
//   		          if (json.status) {
//   		        	  removeForm.dialog( "close" );
//   		        	  location.href = "/legacy/main/Index.do"; 
//   		          }
//   		      });
	}
	
	
	let insertAgree,insertForm,loginForm,pwdForm,uidForm,viewDialog,reviseForm,removeForm;
	
	//회원가입 동의 창!!
	insertAgree = $( "#insertAgree-Dialog" ).dialog({
	    //페이지로드시 자동으로 열림 방지
	    autoOpen: false,
	    height: 650,
    	width: 650,
	    //다른거 안눌림
	    modal: true,
	    //버튼을 누르면 adduser함수 실행
	    buttons: {
	      //여기에 등록버튼을 누르면 보내줄 ajax등록해야함
	      "동의": chBox,
	      //cancel버튼은 창을 닫음
	      "닫기": function() {
	    	  insertAgree.dialog( "close" );
	      }
	    },
    //클로즈는 다음번사용을 위해 폼을 초기화하고 에러창띄웠던거도 삭제함
    close: function() {
      //폼초기화
    	$( "#joinForm" )[0].reset();
    }
  });//회원 가입 동의창
	
	//회원가입 입력 폼
	insertForm = $( "#insertForm-Dialog" ).dialog({
		//페이지로드시 자동으로 열림 방지
		autoOpen: false,
		height: 700,
		width: 600,
		//다른거 안눌림
		modal: true,
		//버튼을 누르면 adduser함수 실행
		buttons: {
			//여기에 등록버튼을 누르면 보내줄 ajax등록해야함
			"회원가입": function(){
				if(insertPwd() == false){
					return;
				}
				insertMember();
			},
			//cancel버튼은 창을 닫음
			"닫기": function() {
				insertForm.dialog( "close" );
			}
		},
		//클로즈는 다음번사용을 위해 폼을 초기화하고 에러창띄웠던거도 삭제함
		close: function() {
			//폼초기화
			$("#insertForm")[0].reset();
		}
	});//회원가입 입력폼
	
	
	//로그인 폼
	loginForm = $( "#loginForm-Dialog" ).dialog({
		//페이지로드시 자동으로 열림 방지
		autoOpen: false,
		height: 450,
		width: 450,
		//다른거 안눌림
		modal: true,
		//버튼을 누르면 adduser함수 실행
		buttons: {
			//여기에 등록버튼을 누르면 보내줄 ajax등록해야함
			"로그인": login,
			//cancel버튼은 창을 닫음
			"닫기": function() {
				loginForm.dialog( "close" );
			}
		},
		//클로즈는 다음번사용을 위해 폼을 초기화하고 에러창띄웠던거도 삭제함
		close: function() {
			//폼초기화
			$("#loginForm")[0].reset();
		}
	});//로그인 폼
	
	//비밀번호 찾기 폼
	pwdForm = $( "#pwdForm-Dialog" ).dialog({
		//페이지로드시 자동으로 열림 방지
		autoOpen: false,
		height: 600,
		width: 450,
		//다른거 안눌림
		modal: true,
		//버튼을 누르면 adduser함수 실행
		buttons: {
			//여기에 등록버튼을 누르면 보내줄 ajax등록해야함
			"비밀번호 변경": pwdFind,
			//cancel버튼은 창을 닫음
			"닫기": function() {
				pwdForm.dialog( "close" );
			}
		},
		//클로즈는 다음번사용을 위해 폼을 초기화하고 에러창띄웠던거도 삭제함
		close: function() {
			//폼초기화
			$("#pwdForm")[0].reset();
		}
	});//비밀번호 찾기 폼
	//아이디 찾기 폼
	uidForm = $( "#uidForm-Dialog" ).dialog({
		//페이지로드시 자동으로 열림 방지
		autoOpen: false,
		height: 450,
		width: 450,
		//다른거 안눌림
		modal: true,
		//버튼을 누르면 adduser함수 실행
		buttons: {
			//여기에 등록버튼을 누르면 보내줄 ajax등록해야함
			"아이디 찾기": uidFind,
			//cancel버튼은 창을 닫음
			"닫기": function() {
				uidForm.dialog( "close" );
			}
		},
		//클로즈는 다음번사용을 위해 폼을 초기화하고 에러창띄웠던거도 삭제함
		close: function() {
			//폼초기화
			$("#uidForm")[0].reset();
		}
	});//아이디 찾기 폼
	//회원 상세보기
	viewDialog = $( "#view-Dialog" ).dialog({
		//페이지로드시 자동으로 열림 방지
		autoOpen: false,
		height: 650,
		width: 500,
		//다른거 안눌림
		modal: true,
		//버튼을 누르면 adduser함수 실행
		buttons: {
			//여기에 등록버튼을 누르면 보내줄 ajax등록해야함
			"회원 탈퇴": function(){
				removeForm.dialog( "open" );
			},
			"회원정보수정": function(){
				reviseForm.dialog( "open" );
			},
			//cancel버튼은 창을 닫음
			"닫기": function() {
				viewDialog.dialog( "close" );
			}
		}
	});//회원 상세보기
	//회원 수정 폼
	reviseForm = $( "#reviseForm-Dialog" ).dialog({
		//페이지로드시 자동으로 열림 방지
		autoOpen: false,
		height: 650,
		width: 550,
		//다른거 안눌림
		modal: true,
		//버튼을 누르면 adduser함수 실행
		buttons: {
			//여기에 등록버튼을 누르면 보내줄 ajax등록해야함
			"회원정보수정": function(){
				if(revisePwd() == false){
					return;
				}
				reviseMember();
			},
			//cancel버튼은 창을 닫음
			"닫기": function() {
				reviseForm.dialog( "close" );
			}
		},
		//클로즈는 다음번사용을 위해 폼을 초기화하고 에러창띄웠던거도 삭제함
		close: function() {
			//폼초기화
			$("#reviseForm")[0].reset();
		}
	});//회원 수정 폼
	//회원 삭제 폼
	removeForm = $( "#removeForm-Dialog" ).dialog({
		//페이지로드시 자동으로 열림 방지
		autoOpen: false,
		height: 450,
		width: 450,
		//다른거 안눌림
		modal: true,
		//버튼을 누르면 adduser함수 실행
		buttons: {
			//여기에 등록버튼을 누르면 보내줄 ajax등록해야함
			"회원탈퇴": removeMember,
			//cancel버튼은 창을 닫음
			"닫기": function() {
				removeForm.dialog( "close" );
			}
		},
		//클로즈는 다음번사용을 위해 폼을 초기화하고 에러창띄웠던거도 삭제함
		close: function() {
			//폼초기화
			$("#removeForm")[0].reset();
		}
	});//회원 삭제 폼
	
	
	
	
// 클릭 이벤트로 창띄우기
	
//	회원가입버튼을 누르면 동의 창이 뜨도록
	$( "#openInsert" ).on( "click", function() {
		insertAgree.dialog( "open" );
	});
//	로그인 오픈
	$( "#openLogin" ).on( "click", function() {
		loginForm.dialog( "open" );
	});
//	비밀번호 찾기 오픈
	$( "#openPwd" ).on( "click", function() {
		pwdForm.dialog( "open" );
	});
//	아아디 찾기 오픈
	$( "#openID" ).on( "click", function() {
		uidForm.dialog( "open" );
	});
//	회원상세보기 오픈
	$( "#openView" ).on( "click", function() {
		viewDialog.dialog( "open" );
	});

//	아이디 존재여부
	$( "#existUid" ).button().on( "click", function() {
		existUid();
	});
	
//	체크박스 다 눌리게 
	$("#chk").on("change",function(){
		let chkBox = document.querySelectorAll(".button");
        for (let i = 0; i < chkBox.length; i++) {
            chkBox[i].checked = true;
        }
	});
	$( "#logoutToggle" ).on( "click", function() {
		
	    $.ajax({
	    	url:"/logout.do",
	    	type:"POST",
	    	contentType: "application/json; charset=UTF-8",
	    	dataType:"json",
	    	success:function(json){
	    		 alert(json.message);
  	          if (json.status) {
  	        	  location.href = Index; 
  	          }
	    	}
	    }); 
		
//		fetch("<c:url value='/member/LogoutMember.do'/>", {
//   	        method: "POST",
//   	        headers: {
//   	          "Content-Type": "application/json; charset=UTF-8",
//   	        },
//   	      })
//   	      .then((response) => response.json())
//   	      .then((json) => {
//   	    	  alert(json.message);
//   	          if (json.status) {
//   	        	  location.href = "<c:url value='/main/Index.do'/>"; 
//   	          }
//   	      });
	});
	
})
