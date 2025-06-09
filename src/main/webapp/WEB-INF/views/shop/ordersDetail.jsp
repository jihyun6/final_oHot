<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/shop/main.css" />
<title>oHoT Shop</title>
</head>
<body>
  <!-- wrapper 시작 -->
  <div class="wrapper">
    <%@ include file="../shopHeader.jsp" %>
    
    <!-- ✅ content 시작 -->
    <div class="content">
      <!-- Title -->
      <div class="container">
        <div class="card card-container-cart-title col-12">
          <h3 class="mt-5 mb-3">주문상세</h3>
        </div>
      </div>
        
      <div class="container">
	    <div class="row">
	      <c:if test="${ empty ordersList}">
	        <div class="card-body card-body-container d-flex justify-content-center align-items-center" style="min-height: 500px;">
	          주문상세 내역이 없습니다.
	        </div>
	      </c:if>
	      
	      <c:forEach var="ordersVO" items="${ordersList}" varStatus="status">
	    
          <div class="card card-container col-12">
            <!-- card body --> 
            <div class="card-body card-body-container">
              <div class="accordion accordion-flush" id="orderAccordion${status.index}">
                <!-- 주문 상품 -->
                <button class="accordion-button collapsed collapsed-accordion-btn" type="button" 
                  data-bs-toggle="collapse" data-bs-target="#orderItemCollapse${status.index}" aria-expanded="false" aria-controls="orderItemCollapse">
                  
                  <div class="col-2 text-start">
                    <h6 class="card-title mb-0">${ordersVO.stlmDt}</h6>
	            	<h6 class="card-title mb-0">주문번호: ${ordersVO.orderNo}</h6>
                  </div>
                  <div class="col-10 text-end">
                    <h5 class="card-title card-title-right">
                     <!-- 주문상품이 단건일경우 /다 건일경우 처리 -->
                    </h5>
                  </div>
                </button>
                
                <!-- 주문상품 상세 화면 -->	    	
                <div id="orderItemCollapse${status.index}" class="accordion-collapse collapse show" data-bs-parent="#orderAccordion${status.index}">	      
                  <div class="accordion-body">
                    <c:forEach var="ordersDetailsVO" items="${ordersVO.ordersDetailsVOList}">
                    <div class="card card-container-bottom-border p-2">
                      <div class="row g-0">
                      <!-- 왼쪽 이미지 -->
                        <div class="col-2 text-center">
                          <c:choose>
                            <c:when test="${ordersDetailsVO.option2 !=null && ordersDetailsVO.gdsNo != 98}">
                              <img src="/upload/${ordersVO.tkFileSaveLocate}" 
                                class="img-fluid rounded" alt="포스터 이미지" style="width: 70px; height: 100px;">
                            </c:when>
                            <c:otherwise>
                              <img src="/upload/${ordersDetailsVO.goodsVO.fileGroupVO.fileDetailVOList[0].fileSaveLocate}" 
                                    class="img-fluid rounded" alt="상품 이미지" style="width: 100px; height: 100px;">
                            </c:otherwise>
                          </c:choose>
                          
                        </div>
                        <div class="col-10">
                          <div class="card-body p-2">
                            <h5 class="card-title mb-1">${ordersDetailsVO.goodsVO.gdsNm}</h5>
<%--                             <p class="card-text mb-0">수량: ${ordersDetailsVO.qty}</p> --%>
<%--                             <p class="card-text mb-0">${ordersDetailsVO.option1}</p> --%>
							<p class="card-text mb-0">
                            <c:choose>
                          	  <c:when test="${ordersDetailsVO.option1 == 'X'}">
                                ${ordersDetailsVO.qty}개
                              </c:when>
                              <c:when test="${ordersDetailsVO.option2 !=null}">
                                <c:if test="${ordersDetailsVO.gdsNo != 98}">
                                  ${ordersDetailsVO.option1} / ${fn:substring(ordersDetailsVO.option2, 6, fn:length(ordersDetailsVO.option2))}
                                </c:if>
                                <c:if test="${ordersDetailsVO.gdsNo == 98}">
                                  ${ordersDetailsVO.option1} / 30일 
                                </c:if>
                              </c:when>
                              <c:otherwise>
                                ${ordersDetailsVO.option1} / ${ordersDetailsVO.qty}개</p>
                              </c:otherwise>
                            </c:choose>
                            <p>
                            <span id="amount">₩<fmt:formatNumber value="${ordersDetailsVO.amount}" pattern="#,###" /></span>
                          </div>
                        </div>
                      </div>
                    </div>
					</c:forEach>

                    <!-- 총합계 영역 -->
                    <div class="d-flex justify-content-between align-items-center mt-3">
                      <span class="fw-bold">총 상품 금액</span>
                      <span class="text-end"><fmt:formatNumber value="${ordersVO.gramt}" pattern="#,###" />원</span>
                    </div>	
                  </div>	   
                </div>
              </div>        
            </div> <!-- 주문 상품 끝 -->
          </div>
          </c:forEach>
	    </div>
      </div>
    </div>
    
    <%@ include file="../shopfooter.jsp" %>
  </div> <!-- wrapper 영역 종료 -->
</body>
</html>