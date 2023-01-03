<div>
	<!-- 헤더부분 -->
	<div class="modal-contentHeader">
	<!-- 로고 -->
		<img class="img img-modalLogo"
		src="${pageContext.request.contextPath}/resources/images/logo.png"
		alt="" />
		<span class="" id="sendDate">2023-xx-xx</span>
		<a href="http://localhost:9090/app/">웹에서보기</a>
	</div>
	<!-- 내용 부분 -->
	<div>
		<textarea class="form-control" id="modalContent"></textarea>
	</div>
	<!-- 푸터 부분 -->
	<div></div>
</div>


<!-- 내용 작성 모달 start
	<div class="modal fade" id="contentModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="contentModal">Modal title</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	      	<div class="modal-content" id="modal-content">
	      		<div>
	      			
	      		</div>
	      	</div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-primary" id="btnContentWriteFinish">Save changes</button>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- 내용 작성 모달 end -->