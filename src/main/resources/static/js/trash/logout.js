/**
 * 
 */

function logout(go, url){
	 fetch(go, {
	        method: "POST",
	        headers: {
	          "Content-Type": "application/json; charset=UTF-8",
	        },
	      })
	      .then((response) => response.json())
	      .then((json) => {
	    	  alert(json.message);
	          if (json.status) {
	        	  location.href = url; 
	          }
	      });
}