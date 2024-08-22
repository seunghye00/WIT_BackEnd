<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="docuModalBack" class="modalBack">
	<div class="eApprModal docuChoiModal">
		<div class="eApprModalTitle">
			문서 양식 선택 <span class="closeModal">X</span>
		</div>
		<div class="choiCont">
			<ul id="docuNameList"></ul>
		</div>
		<div class="modalBtnBox">
			<button class="next">다음</button>
			<button class="cancel red">취소</button>
		</div>
	</div>
</div>
<div class="modalBack" id="apprChoiModalBack">
	<div class="eApprModal apprChoiModal">
		<div class="eApprModalTitle">
			결재선 선택 <span class="closeModal">X</span>
		</div>
		<div class="choiCont">
			<div class="deptList">
				<ul id="deptList"></ul>
			</div>
			<div class="employeeList">
				<ul id="employeeList"></ul>
			</div>
			<div class="arrBtns">
				<button id="addAppr">
					<img src="/img/toggle.png" alt="toggleIcon">
				</button>
				<button id="delAppr">
					<img src="/img/toggle.png" alt="toggleIcon">
				</button>
				<div style="padding: 30px 0;"></div>
				<button id="addRefe">
					<img src="/img/toggle.png" alt="toggleIcon">
				</button>
				<button id="delRefe">
					<img src="/img/toggle.png" alt="toggleIcon">
				</button>
			</div>
			<div class="resultAppr">
				<div class="apprList list">
					<p>결재 순서</p>
					<ul>
						<li id="firAppr">
							<div>첫번째 결재자</div>
						</li>
						<li id="secAppr">
							<div>두번째 결재자</div>
						</li>
						<li id="thirAppr">
							<div>세번째 결재자</div>
						</li>
					</ul>
				</div>
				<div class="refeList list">
					<p>참조 목록</p>
					<ul id="refeList"></ul>
				</div>
			</div>
		</div>
		<div class="modalBtnBox">
			<button class="done">완료</button>
			<button class="prev red">이전</button>
		</div>
	</div>
</div>