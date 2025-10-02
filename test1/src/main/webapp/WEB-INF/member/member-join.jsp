<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Document</title>
	<script src="https://code.jquery.com/jquery-3.7.1.js"
			integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
	<style>
		table, tr, td, th {
			border: 1px solid black;
			border-collapse: collapse;
			padding: 5px 10px;
			text-align: center;
		}
		th { background-color: beige; }
		tr:nth-child(even) { background-color: azure; }
		.phone { width: 40px; }
	</style>
</head>
<body>
	<div id="app">
		<div>
			<label>아이디 :
				<input v-if="!checkFlg" v-model="id">
				<input v-else v-model="id" disabled>
			</label>
			<button @click="fnCheck">중복체크</button>
		</div>
		<div>
			<label>비밀번호 : <input type="password" v-model="pwd"></label>
		</div>
		<div>
			<label>비밀번호 확인 : <input type="password" v-model="pwd2"></label>
		</div>
		<div>
			이름 : <input v-model="name">
		</div>
		<div>
			프로필 사진 : <input type="file" id="file1" name="file1" accept=".jpg, .png">
		</div>
		<div>
			주소 : <input v-model="addr" disabled> <button @click="fnAddr">주소검색</button>
		</div>
		<div>
			핸드폰번호 :
			<input class="phone" v-model="phone1"> -
			<input class="phone" v-model="phone2"> -
			<input class="phone" v-model="phone3">
		</div>
		<div v-if="!joinFlg">
			문자인증 : <input v-model="inputNum" :placeholder="timer">
			<template v-if="!smsFlg">
				<button @click="fnSms">인증번호 전송</button>
			</template>
			<template v-else>
				<button @click="fnSmsAuth">인증</button>
			</template>
		</div>
		<div v-else style="color : red;">
			문자인증이 완료되었습니다.
		</div>
		<div>
			성별 :
			<label><input type="radio" v-model="gender" value="M">남자 </label>
			<label><input type="radio" v-model="gender" value="F">여자 </label>
		</div>
		<div>
			가입 권한 :
			<select v-model="status">
				<option value="A">관리자</option>
				<option value="S">판매자</option>
				<option value="C">소비자</option>
			</select>
		</div>
		<div>
			<button @click="fnJoin">회원가입</button>
		</div>
	</div>
</body>
</html>
<script>
	function jusoCallBack(roadFullAddr, roadAddrPart1, addrDetail, roadAddrPart2, engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn, detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn, buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno, emdNo) {
		window.vueObj.fnResult(roadFullAddr, addrDetail, zipNo);
	}

	const app = Vue.createApp({
		data() {
			return {
				id: "",
				pwd: "",
				pwd2: "",
				addr: "",
				name: "",
				phone1: "",
				phone2: "",
				phone3: "",
				gender: "M",
				status: "A",
				checkFlg: false,
				inputNum: "",
				smsFlg: false,
				timer: "",
				count: 180,
				joinFlg: false,
				ranStr: "",
			};
		},
		methods: {
			fnCheck: function () {
				let self = this;
				let param = { id: self.id };
				$.ajax({
					url: "/member/check.dox",
					dataType: "json",
					type: "POST",
					data: param,
					success: function (data) {
						if (data.result == "true") {
							alert("이미 사용중인 아이디 입니다");
						} else {
							alert("사용 가능한 아이디 입니다");
							self.checkFlg = true;
						}
					}
				});
			},
			fnAddr: function () {
				window.open("/addr.do", "addr", "width=500, height=500");
			},
			fnResult: function (roadFullAddr, addrDetail, zipNo) {
				let self = this;
				self.addr = roadFullAddr;
			},
			fnSms: function () {
				let self = this;
				let param = {};
				$.ajax({
					url: "/send-one",
					dataType: "json",
					type: "POST",
					data: param,
					success: function (data) {
						if (data.res.statusCode == "2000") {
							alert("문자 전송 완료");
							self.ranStr = data.ranStr;
							self.smsFlg = true;
							self.fnTimer();
						} else {
							alert("잠시 후 다시 시도해주세요.");
						}
					}
				});
			},
			fnTimer: function () {
				let self = this;
				let interval = setInterval(function () {
					if (self.count == 0) {
						clearInterval(interval);
						alert("시간이 만료되었습니다!");
					} else {
						let min = parseInt(self.count / 60);
						let sec = self.count % 60;
						min = min < 10 ? "0" + min : min;
						sec = sec < 10 ? "0" + sec : sec;
						self.timer = min + " : " + sec;
						self.count--;
					}
				}, 1000);
			},
			fnSmsAuth: function () {
				let self = this;
				if (self.ranStr == self.inputNum) {
					alert("문자인증이 완료되었습니다.");
					self.joinFlg = true;
				} else {
					alert("문자인증에 실패했습니다.");
				}
			},
			fnJoin: function () {
				let self = this;
				
				if (!self.checkFlg) {
					alert("아이디 중복체크 후 시도해주세요.");
					return;
				}
				const idRegex = /^[a-z0-9]{5,12}$/;
				if (!idRegex.test(self.id)) {
					alert("아이디는 영문 소문자와 숫자로만 5~12자리로 입력해주세요.");
					return;
				}
				const pwdRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
				if (!pwdRegex.test(self.pwd)) {
					alert("비밀번호는 영문 대/소문자, 숫자, 특수문자를 포함하여 8자 이상이어야 합니다.");
					return;
				}
				if (self.pwd != self.pwd2) {
					alert("비밀번호는 다시 확인해주세요.");
					return;
				}
				if (self.name == "") {
					alert("이름을 입력해주세요.");
					return;
				}
				if (self.addr == "") {
					alert("주소를 입력해주세요.");
					return;
				}
				if (self.phone1 == "" || self.phone2 == "" || self.phone3 == "") {
					alert("핸드폰번호를 입력해주세요.");
					return;
				}
				
				let phone = self.phone1 + "-" + self.phone2 + "-" + self.phone3;
				let param = {
					id: self.id,
					pwd: self.pwd,
					name: self.name,
					addr: self.addr,
					phone: phone,
					gender: self.gender,
					status: self.status
				};

				// 1단계: 사용자 텍스트 정보 먼저 전송
				$.ajax({
					url: "/member/add.dox",
					dataType: "json",
					type: "POST",
					data: param,
					success: function (data) {
						if (data.result == "success") {
							// 2단계: 프로필 사진 업로드
							if ($("#file1")[0].files.length > 0) {
								alert("회원 정보가 등록되었습니다. 프로필 사진을 업로드합니다.");
								var form = new FormData();
								form.append("file1", $("#file1")[0].files[0]);
								form.append("userId", data.userId);
								self.uploadProfile(form);
							} else {
								alert("가입되었습니다!");
								location.href = "/login.do";
							}
						} else {
							alert("회원가입 중 오류가 발생했습니다.");
						}
					},
					error: function(xhr, status, error) {
						alert("서버와 통신에 실패했습니다.");
					}
				});
			},
			uploadProfile: function(form){
				$.ajax({
					url : "/profileUpload.dox",
					type : "POST",
					processData : false,
					contentType : false,
					data : form,
					dataType: "json", // 서버로부터 json 형식의 응답을 기대
					success:function(response) { 
						if(response.result == 'success') {
							alert("프로필 사진 업로드 성공! 가입이 완료되었습니다.");
						} else {
							alert("프로필 사진 업로드에 실패했습니다. 기본 이미지로 설정됩니다.");
						}
						location.href = "/login.do";
					},
					error: function() {
						alert("프로필 사진 업로드 중 서버 오류가 발생했습니다.");
						location.href = "/login.do";
					}
				});
			}
		},
		mounted() {
			let self = this;
			window.vueObj = this;
		}
	});

	app.mount('#app');
</script>