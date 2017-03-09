<c:forEach var="i" begin="0" end="4">
	<c:choose>
	<c:when test="${files[i] == null}">
		<td><img src = "${pageContext.request.contextPath }/views/imag/storage/1.png" width="90px" ></td>
	</c:when>
	<c:otherwise>
	<c:choose>
	<c:when test="${noArr[i]==no}">
				<td class="td_padding">
				<a href="javascript:read('${ noArr[i]}')">
				<img class = "curImg" src = "${pageContext.request.contextPath }/views/imag/storage/${files[i]}" width="90px" border="0">
				</a></td>
	</c:when>
	<c:otherwise>
				<td class="td_padding"><a href ="javascript:read('${noArr[i]}')">
				<img src="${pageContext.request.contextPath }/views/imag/storage/${files[i]}" width="80px" border="0">
				</a></td>
	
	</c:otherwise>
	</c:choose>

	</c:otherwise>
	</c:choose>
	</c:forEach>