package lecture.section2.run.c_preparedStatement;

import lecture.section2.model.MenuDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

import static lecture.section2.common.JDBCTemplate.getConnection;

public class Application2 {
    public static void main(String[] args) {

        Scanner sc = new Scanner(System.in);
        // 최대 최소 메뉴 가격 범위에서 판매여부에 따라 조회
        System.out.print("최소 메뉴 가격을 입력하세요 : ");
        int minPrice = Integer.parseInt(sc.nextLine());
        System.out.print("최대 메뉴 가격을 입력하세요 : ");
        int maxPrice = Integer.parseInt(sc.nextLine());
        System.out.print("판매 여부를 입력하세요(Y/N) : ");
        String orderableStatus = sc.nextLine();

        // ? : 위치 홀더
        String query = "select * from tbl_menu where menu_price between ? and ? and orderable_status = ?"; // 먼저 있어야 만들 수 있음

        List<MenuDTO> menuList = new ArrayList<>();

        try(
                Connection con = getConnection(); // 1. 커넥션 만들기
                PreparedStatement pstmt = con.prepareStatement(query); // 2. PreparedStatement 객체 만들기
                ) {

            pstmt.setInt(1, minPrice); // pstmt 완성 (위치홀더 지정, 값)
            pstmt.setInt(2, maxPrice); // pstmt 완성 (위치홀더 지정, 값)
            pstmt.setString(3, orderableStatus); // pstmt 완성 (위치홀더 지정, 값)

            ResultSet rset = pstmt.executeQuery(); // 쿼리 실행

            while (rset.next()) {
                menuList.add(new MenuDTO(
                        rset.getInt("menu_code"),
                        rset.getString("menu_name"),
                        rset.getInt("menu_price"),
                        rset.getInt("category_code"),
                        rset.getString("orderable_status")));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        // 저장된 결과 출력
        if(!menuList.isEmpty()) {
            for (MenuDTO menu : menuList){
                System.out.println("menu = " + menu);
            }
        } else {
            System.out.println("입력하신 정보에 맞는 메뉴가 없습니다.");
        }
    }
}
