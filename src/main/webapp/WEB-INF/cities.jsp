<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>CityList</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<link rel="stylesheet" href="/static/css/bootstrap.min.css">
<link rel="stylesheet" href="/static/css/customize.css">
<link rel="shortcut icon" type="image/x-icon" href="/static/favicon.ico" />
<script type="text/javascript" src="/static/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="/static/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/static/layer/layer.js"></script>
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
	<%--ウェブページを構築する--%>
	<div class="container">
		<%--タイトル--%>
		<div class="row">
			<div class="col-lg-12">
				<h1>グローバル都市情報一覧</h1>
			</div>
		</div>
		<%--検索バーとボタン--%>
		<div class="row">
			<form class="form-inline col-lg-5" role="form">
				<div class="input-group col-lg-5">
					<span class="input-group-text">@</span> <input id="keywordInput"
						class="form-control" type="text" placeholder="検索条件を入力してください">
					<button id="searchBtn" class="btn btn-warning my-2 my-sm-0"
						type="button">
						<i class="fa-solid fa-magnifying-glass"></i> 検索
					</button>
				</div>
			</form>
			<div class="col-lg-2 offset-lg-5">
				<button class="btn btn-success" id="cityAddModalBtn">
					<i class="fa-solid fa-tree-city"></i> 情報追加
				</button>
			</div>
		</div>
		<%--データ--%>
		<div class="row">
			<div class="col-lg-12">
				<table id="cityTable" class="table table-hover table-sm">
					<caption style="font-size: 12px;">Information of populous
						cities gathered around 2000s'</caption>
					<thead>
						<tr class="table-success">
							<th scope="col" class="text-center" style="width: 70px;">都市ID</th>
							<th scope="col" class="text-center" style="width: 120px;">都市名</th>
							<th scope="col" class="text-center" style="width: 100px;">大陸</th>
							<th scope="col" class="text-center" style="width: 100px;">国家</th>
							<th scope="col" class="text-center" style="width: 120px;">地域</th>
							<th scope="col" class="text-center" style="width: 70px;">人口数量</th>
							<th scope="col" class="text-center" style="width: 80px;">公用語</th>
							<th scope="col" class="text-center" style="width: 120px;">操作</th>
						</tr>
					</thead>
					<tbody id="cityTableBody" class="table-group-divider"></tbody>
				</table>
				<%--ページナビ--%>
				<div class="row">
					<div id="pageInfos" class="col-lg-5"></div>
					<div id="pageNavi" class="col-lg-7 d-flex justify-content-end"></div>
				</div>
			</div>
		</div>
	</div>
	<%--データ追加モーダル--%>
	<div class="modal fade" id="cityAddModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">都市情報追加</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group row">
							<label for="nameInput" class="col-sm-3 col-form-label text-end">都市名</label>
							<div class="col-sm-9" style="height: 60px;">
								<input type="text" class="form-control" id="nameInput"
									placeholder="都市の正式的な名称"> <span class="form-text"
									style="font-size: 12px;"></span>
							</div>
						</div>
						<div class="form-group row">
							<label for="continentInput"
								class="col-sm-3 col-form-label text-end">大陸</label>
							<div class="col-sm-9" style="height: 60px;">
								<select id="continentInput" class="form-select"></select>
							</div>
						</div>
						<div class="form-group row">
							<label for="nationInput" class="col-sm-3 col-form-label text-end">国家</label>
							<div class="col-sm-9" style="height: 60px;">
								<select id="nationInput" class="form-select"></select>
							</div>
						</div>
						<div class="form-group row">
							<label for="districtInput"
								class="col-sm-3 col-form-label text-end">地域</label>
							<div class="col-sm-9" style="height: 60px;">
								<input type="text" class="form-control" id="districtInput"
									placeholder="都市の地域"> <span class="form-text"
									style="font-size: 12px;"></span>
							</div>
						</div>
						<div class="form-group row">
							<label for="populationInput"
								class="col-sm-3 col-form-label text-end">人口数量</label>
							<div class="col-sm-9" style="height: 60px;">
								<input type="text" class="form-control" id="populationInput"
									placeholder="都市の人口数量"> <span class="form-text"
									style="font-size: 12px;"></span>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">閉じる</button>
					<button type="button" class="btn btn-primary" id="cityInfoSaveBtn">保存</button>
				</div>
			</div>
		</div>
	</div>
	<%--データ編集モーダル--%>
	<div class="modal fade" id="cityEditModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">都市情報修正</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group row">
							<label for="nameEdit" class="col-sm-3 col-form-label text-end">都市名</label>
							<div class="col-sm-9" style="height: 60px;">
								<p class="form-control" id="nameEdit"></p>
							</div>
						</div>
						<div class="form-group row">
							<label for="continentEdit"
								class="col-sm-3 col-form-label text-end">大陸</label>
							<div class="col-sm-9" style="height: 60px;">
								<p class="form-control" id="continentEdit"></p>
							</div>
						</div>
						<div class="form-group row">
							<label for="nationEdit" class="col-sm-3 col-form-label text-end">国家</label>
							<div class="col-sm-9" style="height: 60px;">
								<select id="nationEdit" class="form-select"></select>
							</div>
						</div>
						<div class="form-group row">
							<label for="languageEdit"
								class="col-sm-3 col-form-label text-end">公用語</label>
							<div class="col-sm-9" style="height: 60px;">
								<p class="form-control" id="languageEdit"></p>
							</div>
						</div>
						<div class="form-group row">
							<label for="districtEdit"
								class="col-sm-3 col-form-label text-end">地域</label>
							<div class="col-sm-9" style="height: 60px;">
								<input type="text" class="form-control" id="districtEdit"
									placeholder="都市の地域"> <span class="form-text"
									style="font-size: 12px;"></span>
							</div>
						</div>
						<div class="form-group row">
							<label for="populationEdit"
								class="col-sm-3 col-form-label text-end">人口数量</label>
							<div class="col-sm-9" style="height: 60px;">
								<input type="text" class="form-control" id="populationEdit"
									placeholder="都市の人口数量"> <span class="form-text"
									style="font-size: 12px;"></span>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger"
						data-bs-dismiss="modal">閉じる</button>
					<button type="button" class="btn btn-info" id="cityInfoChangeBtn">変更</button>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="/static/js/citinavi.js"></script>
</body>
</html>