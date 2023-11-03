package com.project.boot.dto;

import java.io.Serializable;
import java.util.Collection;
import java.util.Objects;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder

public class Member implements UserDetails{
	//필드 : 객체를 파일로 저장하기 위해 직렬화가 필요한데 이를위한 Serializable의 번호
	private static final long serialVersionUID = -1036524153261734687L;
	//필드 : 회원들의 정보를 저장하기 위한 변수
	//순서번호저장
	private int nrow;
	private String uid;
	private String name;
	private String pwd;
	private String age;
	private String phone;
	private String address;
	private String gender;
	private String email;
	//삭제할 멤버들의 아이디
	private String[] members;
	//삭제된 멤버아이디의 개숫
	private int deleteCount;
	
	private int boardid;
	
	//페이징을 위함
	//검색필드
	private String searchTitle = "";
	
	//페이징
	private int pageNo = 1; //현재 페이지 번호
	private int totalCount; // 전체건수
	private int totalPageSize; // 전체 페이지 수
	private int pageLength = 10; // 한페이지의 길이
	private int navSize = 10; //페이지 하단에 출력되는 페이지의 항목수
	private int navStart = 0; //페이지 하단에 출력되는 페이지 시작번호
	private int navEnd = 0; // 페이지 하단에 출력되는 페이지 끝 번호
	
	
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		//페이지 건수 계산
		totalPageSize = (int) Math.ceil((double) totalCount/ pageLength);
		//페이지 네비게이터 시작 페이지를 계산한다.
		navStart = ((pageNo - 1)/ navSize)* navSize +1;
		//페이지 네비게이터 끝 페이지를 계산한다.
		navEnd = ((pageNo-1)/navSize + 1)* navSize;
		//전체 페이지보다 크면 전체 페이지값으로 변경한다.
		if(navEnd >= totalPageSize) {
			navEnd = totalPageSize;
		}
	}
	//페이지 네비게이터의 처음 시작 번호
	public int getStartNo() {
		return (pageNo - 1) * pageLength + 1;
	}
	//페이지 네비게이터의 마지막 번호
	public int getEndNo() {
		return pageNo * pageLength;
	}
	
	
	
	
	
	
	
	
	
	///////////////////
	//메소드 : 객체 비교를 위한 equals 와 hashcode
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Member other = (Member) obj;
		return Objects.equals(uid, other.uid);
	}
	
	@Override
	public int hashCode() {
		return Objects.hash(uid);
	}

	public boolean isAdmin() {
		return Objects.equals("root", uid);
	}
	public boolean isPwd(String pwd) {
		return this.pwd.equals(pwd);
	}
	public boolean isNamePhone(Member member) {
		return this.name.equals(member.getName())
				&& this.phone.equals(member.getPhone());
	}
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public String getPassword() {
		// TODO Auto-generated method stub
		return this.pwd;
	}
	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return this.uid;
	}
	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}
	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return true;
	}
	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}
	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return true;
	}
}
