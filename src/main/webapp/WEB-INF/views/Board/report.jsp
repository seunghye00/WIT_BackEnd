<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Insert title here</title>
            <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
        </head>

        <body>
            <c:forEach var="post" items="${reportedPosts}">
                <tr>
                    <td>글 번호 : ${post.board_seq}</td>
                    <td>사원 번호 : ${post.emp_no}</td>
                    <td>제목 : ${post.title }</td>
                    <td>내용 : ${post.contents }</td>
                    <td>작성일 : ${post.write_date }</td>
                    <td>조회수 : ${post.views }</td>
                    <td>보드코드 : ${post.board_code }</td>
                    <td>신고유형 : ${post.report_type }</td>
                    <td>신고날짜 : ${post.report_date }</td>
                    
                </tr>
            </c:forEach>
        </body>

        </html>