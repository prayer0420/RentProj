package utils;

import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class MybatisSqlSessionFactory {
	private static SqlSessionFactory sqlSessionFactory;
	static {
		try {
			String resource = "resource/mybatis-config.xml";
			InputStream inputStream = Resources.getResourceAsStream(resource);
			if (inputStream == null) {
			    System.out.println("❌ Config 파일을 찾지 못했습니다: " + resource);
			}
			
			//SqlSessionFactoryBuilder생성
			SqlSessionFactoryBuilder builder = new SqlSessionFactoryBuilder();
			sqlSessionFactory = builder.build(inputStream);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public static SqlSessionFactory getSqlSessionFactory() {
		return sqlSessionFactory;
	}
	
	
}
