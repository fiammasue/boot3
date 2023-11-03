package com.project.boot.type;

import java.sql.Array;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.MappedJdbcTypes;
import org.apache.ibatis.type.MappedTypes;

import oracle.sql.ARRAY;
import oracle.sql.ArrayDescriptor;

@MappedJdbcTypes({ JdbcType.ARRAY })
@MappedTypes({ Object.class })
public class OracleStrArrTypeHandler extends BaseTypeHandler<Object> {

	//oracle에서 사용되는 선언해둔 type
	private static final String STRING_ARRAY = "VARCHAR_ARRAY_TYPE";

	@Override
	public void setNonNullParameter(PreparedStatement ps, int i, Object parameter, JdbcType jdbcType)
			throws SQLException {
		Connection conn = ps.getConnection();
		//Array array =  ps.getConnection();//.createArrayOf(STRING_ARRAY, list.toArray());
		ArrayDescriptor desc = ArrayDescriptor.createDescriptor(STRING_ARRAY,conn);
		parameter = new ARRAY(desc,conn,(String[]) parameter);
		System.out.println("parameter -> " + parameter);
		ps.setArray(i, (oracle.sql.ARRAY)parameter);
		
		
	}

	@Override
	public Object getNullableResult(ResultSet rs, String columnName) throws SQLException {
		// TODO Auto-generated method stub
		 return extractArray(rs.getArray(columnName));
	}

	protected Object extractArray(Array array) throws SQLException {
		  if (array == null) {
		      return null;
		    }
		    Object javaArray = array.getArray();
		    array.free();
		    return new ArrayList<>(Arrays.asList((Object[])javaArray));
	}
	

	@Override
	public Object getNullableResult(ResultSet rs, int columnIndex) throws SQLException {
		// TODO Auto-generated method stub
		return extractArray(rs.getArray(columnIndex));
	}

	@Override
	public Object getNullableResult(CallableStatement cs, int columnIndex) throws SQLException {
		// TODO Auto-generated method stub
		 return extractArray(cs.getArray(columnIndex));
	}
	
	

}