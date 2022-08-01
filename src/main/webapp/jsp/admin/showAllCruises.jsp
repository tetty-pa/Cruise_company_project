<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Cruises</title>
    <jsp:include page="/jsp/header.jsp"/>
</head>
<body>

<div class="table__container">
    <div class="title">Cruises</div>

    <table class="table table-bordered table-light" id="cruises-details">
        <tr>
            <th>Cruise</th>
            <th>Description</th>
            <th>NumberOfPorts</th>
            <th>StartDate</th>
            <th>EndDate</th>
            <th>Price</th>

        </tr>
        <c:forEach items="${requestScope.cruises}" var="cruise">

            <tr>
                <td class="data">${cruise.cruiseName}</td>
                <td class="data">${cruise.description}</td>
                <td class="data">${cruise.numberOfPorts}</td>
                <td class="data">${cruise.startDate}</td>
                <td class="data">${cruise.endDate}</td>
                <td class="data">${cruise.price}</td>

                <td>
                        <%--
                                            <button class="save"> Save</button>
                        --%>
                    <a class="save"
                       href="${pageContext.request.contextPath}/controller/?command=updateCruise&id=${cruise.id}&cruiseName=${cruise.cruiseName}&description=${cruise.description}&numberOfPorts=${cruise.numberOfPorts}&startDate=${cruise.startDate}&endDate=${cruise.endDate}&price=${cruise.price}">Save</a>

                    <button class="edit" id="edit"> Edit</button>
                    <a class="delete"
                       href="${pageContext.request.contextPath}/controller/?command=deleteCruise&id=${cruise.id}">Delete</a>
                    <a class="link-dark"
                       href="${pageContext.request.contextPath}/controller/?command=showAllUsersByCruise&id=${cruise.id}">Users</a>
                </td>
                    <%--      <form method="POST" action="${pageContext.request.contextPath}/controller/">
                              <input type="hidden" name="command" value="updateCruise"/>
                              <input type="hidden" name="id" value="${cruise.id}"/>
                              <input type="hidden" name="route" value="${cruise.route}"/>
                              <input type="hidden" name="cruiseName" value="${cruise.cruiseName}"/>
                              <input type="hidden" name="description" value="${cruise.description}"/>
                              <input type="hidden" name="numberOfPorts" value="${cruise.numberOfPorts}"/>
                              <input type="hidden" name="startDate" value="${cruise.startDate}"/>
                              <input type="hidden" name="endDate" value="${cruise.endDate}"/>
                              <input type="hidden" name="price" value="${cruise.price}"/>
                                  &lt;%&ndash;
                                                          <a href="${pageContext.request.contextPath}/controller/?command=updateCruise">update</a>
                                  &ndash;%&gt;

                              <button class="update" type="submit"> Update</button>--%>
            </tr>
            <%--<div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button id="edit-cruise-button" type="button" class="btn btn-primary">Edit</button>
            </div>--%>
        </c:forEach>
    </table>


</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
    $(document).on('click', '.edit', function () {
        $(this).parent().siblings('td.data').each(function () {
            let content = $(this).html();
            $(this).html('<input value="' + content + '" />');
        });
        $(this).siblings('.save').show();
        $(this).siblings('.delete').hide();
        $(this).hide();
    });
    $(document).on('click', '.save', function () {
        $('input').each(function () {
            let content = $(this).val();
            console.log(content);
            $(this).html(content);
            $(this).contents().unwrap();
        });
        $(this).siblings('.edit').show();
        $(this).siblings('.delete').show();
        $(this).siblings('.update').show();
        $(this).hide();
    });
    $(document).on('click', '.delete', function () {
        $(this).parents('tr').remove();
    });
    /*   $('.add').click(function () {
           $(this).parents('table')
               .append('<tr><td class="data"></td><td class="data"></td><td class="data"></td><td><button class="save">Save</button><button class="edit">Edit</button> <button class="delete">Delete</button></td></tr>');
       });*/
</script>
</body>
</html>