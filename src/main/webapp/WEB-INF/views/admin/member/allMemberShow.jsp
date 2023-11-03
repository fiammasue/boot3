<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원전체보기</title>
<link rel="stylesheet" href="<c:url value='/css/allMemberShow.css'/>">
<script src="<c:url value='/js/loadDomMemberAdmin.js'/>"></script>
</head>
<body>
<div id="contain">
<form name="pageForm" id="pageForm" action="<c:url value='/admin/member/AdminMember.do'/>" method="post">
	<input type="hidden" name="pageNo" id="pageNo" value="${result.member.pageNo }"/>
	<input type="hidden" name="searchTitle" id="searchTitle" value="${result.member.searchTitle }"/>
	<input type="hidden" name="pageLength" id="pageLength" value="${result.member.pageLength }"/>
</form>
<form onsubmit="jsSearchValue()" name="mForm" id="mForm" action="<c:url value='/admin/member/AdminMember.do'/>" method="post">
	<input type="hidden" name="pageNo" id="pageNo" value="${result.member.pageNo }"/>
		
			<div>
				<label>건수 : </label>
				<select name="pageLength" id="pageLength">
					<option value="10" ${result.member.pageLength == 10? 'selected="selected"':'' }>10건</option>
					<option value="20" ${result.member.pageLength == 20? 'selected="selected"':'' }>20건</option>
					<option value="50" ${result.member.pageLength == 50? 'selected="selected"':'' }>50건</option>
					<option value="100" ${result.member.pageLength == 100? 'selected="selected"':'' }>100건</option>			
				</select>
				</div>
				<div id="search-window">
				<label>아이디 : </label>
				<input type="text" name="searchTitle" id="searchTitle" value="${result.member.searchTitle }"/>
				<input type="submit" value="검색"/>
			</div>

</form>
<form  method='post' onsubmit="return false;">
	
		<table class="tb">
<!-- 		<tr id="memberItem" style="display:none">
	      	<td style="display:none" id="nrow"></td>
	      	<th><input type='checkbox' class="memberid" name='memberid' id="box" value='{uid}' checked></th>
			<td class="col" id="memberid"></td>
			<td id="pwd"></td>
			<td id="name"></td>
			<td id="age"></td>
			<td id="phone"></td>
			<td id="address"></td>
			<td id="gender"></td>
			<td id="email"></td>
			<td><a href="javascript:jsDelOne('{uid}')" id="delOne">삭제</a></td>
      	</tr> -->
		
			<caption>회원목록</caption>
			
			<tbody id="memberList">
			<tr class="head">
			<th>전체선택  <input type='checkbox' id='chk' onchange="jsCheckbox()"></th>
				<th>아이디</th>
				<th>비밀번호</th>
				<th>이름</th>
				<th>전화번호</th>
				<th>주소</th>
				<th>이름</th>
				<th>성별</th>
				<th>이메일</th>
				<th>삭제</th>
			</tr>

			<c:if test="${not empty result.memberList}">
				<c:forEach var="member" items="${result.memberList }">
					<tr>
						<th><input type='checkbox' class="memberid" name='memberid' value='${member.uid}'></th>
						<td style="display:none">${member.nrow }</td>
						<td class="col">${member.uid }</td>
						<td>${member.pwd }</td>
						<td>${member.name}</td>
						<td>${member.age }</td>
						<td>${member.phone }</td>
						<td>${member.address }</td>
						<td>${member.gender }</td>
						<td>${member.email }</td>
						<td><a onclick="javascript:jsDelOne('${member.uid}')">삭제</a></td>
					</tr>
				</c:forEach>
			</c:if>
		</tbody>

		</table>
		<input style="border: none;padding: 10px;border-radius: 5px;background-color: #d36f12b3;color: white;" class="delete-button" type='submit' value="삭제" onclick="jsSelectedDelete()">
		
		</form>
		<div>
			<c:if test="${result.member.navStart != 1 }">
				<a href="javascript:jsPageNo(${result.member.navStart-1 })">&lt;</a>
			</c:if>
		<c:forEach var="item" begin="${result.member.navStart }" end="${result.member.navEnd }">
			<c:choose>
				<c:when test="${result.member.pageNo != item }">
					<label><a href="javascript:jsPageNo(${item })">${item }</a></label>
				</c:when>
				<c:otherwise>
					<strong>${item }</strong>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<c:if test="${result.member.navEnd != result.member.totalPageSize }">
			<a href="javascript:jsPageNo(${result.member.navEnd+1 })">&gt;</a>
		</c:if>
		
		</div>
		
		<a href="<c:url value='/admin/main.do'/>">메인페이지로</a>
	</div>


</body>

	<script>

	
		function jsSearchValue(){
			document.querySelector("#mForm > #pageNo").value = "1";
			return true;
		}
		function jsCheckbox(){
			let allChk = document.querySelector("#chk");
		    let memberIds = document.querySelectorAll(".memberid");
		    
		    memberIds.forEach(e=>e.checked = allChk.checked);
			
		}

		function jsPageNo(pageNo){
			document.querySelector("#pageForm > #pageNo").value = pageNo;
			//페이지번호가 계속 기본값 10으로 초기화되는 문제가 발생해서 그냥 직접 대입해줬음
			document.querySelector("#pageForm > #pageLength").value = ${result.member.pageLength};
			document.querySelector("#pageForm").submit();
		}
		function jsSelectedDelete(){
			if (!confirm("선택한 회원을 삭제하시겠습니까?")) return false;
			
			var members = []
			var checkboxes = document.querySelectorAll("input[name='memberid']:checked");
			checkboxes.forEach(function(checkbox) {
  				members.push(checkbox.value);
  				var first = checkbox.parentNode;
  				//if(first && first.tagName=== 'TR')
  					//한줄 dom객체 날리기
  				first.parentNode.parentNode.removeChild(first.parentNode);
  			});
			
		    const param = {
			        members:members,
			        deleteCount:members.length,
			};
	
			      fetch("<c:url value='/admin/member/DeleteMembers.do'/>", {
			        method: "POST",
			        headers: {
			          "Content-Type": "application/json; charset=UTF-8",
			        },
			        body: JSON.stringify(param),
			      })
			      .then((response) => response.json())
			      .then((json) => {
			          if (json.status) {
			        	  
			    	  alert(json.message);
			        	  
			        	  const memberList = json.memberList;
			        	  
			        	  for (let i=0;i<memberList.length;i++) {
				        	  const member = memberList[i];
							  
				        	  memberInfo = [];
				        	  
				        	 memberInfo += "<tr>" ;
				        	 memberInfo += "<td style='display:none;' id='nrow'></td>";
				        	 memberInfo += "<th><input type='checkbox' class='memberid' name='memberid' id='box' value='"+ member.uid +"'></th>";
				        	 memberInfo += "<td class='col' id='memberid'>"+ member.uid+"</td>";
				        	 memberInfo += "<td id='pwd'>"+ member.pwd +"</td>";
				        	 memberInfo += "<td id='name'>"+member.name+"</td>";
				  			 memberInfo += "<td id='age'>"+member.age+"</td>";
				  			 memberInfo += "<td id='phone'>"+member.phone+"</td>";
				  			 memberInfo += "<td id='address'>"+member.address+"</td>";
				  			 memberInfo += "<td id='gender'>"+member.gender+"</td>";
				  			 memberInfo += " <td id='email'>"+member.email+"</td>";
				  			 memberInfo += " <td><a href='javascript:jsDelOne("+member.uid+")' id='delOne'>삭제</a></td>";
				  			 memberInfo += " </tr> ";
				     
				  			$('#memberList').html($('#memberList').html()+memberInfo)

			        	  }
			          }else{
			        	  alert(json.message);
			          }
			      });
			
		}
		function jsDelOne(memberid){
			if (!confirm("선택한 회원을 삭제하시겠습니까?")) return false;
			
			var members = []
			//받아온하나의 값 넣기
			//삭제할 필드를 하나만 쓰고 싶었음
			members.push(memberid);
	
			var domElement = document.querySelector("[value='" + memberid + "']");
			var first = domElement.parentNode;
			//if(first && first.tagName=== 'TR')
			first.parentNode.parentNode.removeChild(first.parentNode);

		    const param = {
			        members:members,
			        deleteCount:members.length,
			};
	
			      fetch("<c:url value='/admin/member/DeleteMembers.do'/>", {
			        method: "POST",
			        headers: {
			          "Content-Type": "application/json; charset=UTF-8",
			        },
			        body: JSON.stringify(param),
			      })
			      .then((response) => response.json())
			      .then((json) => {
			    	  alert(json.message);
			          if (json.status) {
			        	  const member = json.memberList[0];
			        	  var memberInfo = [];
			        	  
				        	 memberInfo += "<tr>" ;
				        	 memberInfo += "<td style='display:none;' id='nrow'></td>";
				        	 memberInfo += "<th><input type='checkbox' class='memberid' name='memberid' id='box' value='"+ member.uid +"'></th>";
				        	 memberInfo += "<td class='col' id='memberid'>"+ member.uid+"</td>";
				        	 memberInfo += "<td id='pwd'>"+ member.pwd +"</td>";
				        	 memberInfo += "<td id='name'>"+member.name+"</td>";
				  			 memberInfo += "<td id='age'>"+member.age+"</td>";
				  			 memberInfo += "<td id='phone'>"+member.phone+"</td>";
				  			 memberInfo += "<td id='address'>"+member.address+"</td>";
				  			 memberInfo += "<td id='gender'>"+member.gender+"</td>";
				  			 memberInfo += " <td id='email'>"+member.email+"</td>";
				  			 memberInfo += " <td><a href='javascript:jsDelOne("+member.uid+")' id='delOne'>삭제</a></td>";
				  			 memberInfo += " </tr> ";
				     
				  			$('#memberList').html($('#memberList').html()+memberInfo)
			        	  }
			          })
			      }
		



	</script>



</html>