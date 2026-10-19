package lecture.section2.run.b_sqlInjection;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import static lecture.section2.common.JDBCTemplate.*;

public class Application1 {

    // 사용자입력
    private static String menuName = "한우딸기국밥";
    private static String orderableStatus = "Y";

    public static void main(String[] args) {

        // 1. 커넥션생성
        Connection con = getConnection();

        // 2. Statement 객체 생성
        Statement stmt= null;

        // 3. ResultSet 객체 생성
        ResultSet rset = null;

        // 4. 쿼리 작석
        String query = "select * from tbl_menu where menu_name = '" + menuName + "' and orderable_status = '" + orderableStatus + "'";
//        System.out.println("query = " + query);

        try {
            // 5. Statement를 이용해서 쿼리 실행
            stmt = con.createStatement(); // Connection으로 statement 객체 생성

            rset = stmt.executeQuery(query); // 쿼리실행

            // 6. ResultSet에서 결과를 꺼내기 (가공)
            if(rset.next()) {
                System.out.println(rset.getString("menu_name") + " 메뉴는 주문 가능합니다.");
            } else {
                System.out.println("주문 가능한 메뉴가 아닙니다.");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            close(rset);
            close(stmt);
            close(con);
        }
    }
}
