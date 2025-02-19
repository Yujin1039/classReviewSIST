$(function(){
	let rowCount = 10;
	let currentPage;
	let count;
	/*===============================
	 * 댓글 목록
	 * ============================== */
	function selectList(pageNum){
		currentPage = pageNum;
		//로딩 이미지 노출
		$('#loading').show();
		//서버와 통신
		//     식별자(key) 변수->데이터 전송
		//data:{pageNum:pageNum}
		//식별자는 작성한 문자 그대로 전송, 변수는 js파일에서 변수에 저장한 값으로 전송		
		$.ajax({
			url:'listReply.do',
			type:'post',
			data:{pageNum:pageNum,rowCount:rowCount,board_num:$('#board_num').val()},
			dataType:'json',
			success:function(param){
				//로딩 이미지 감추기
				$('#loading').hide();
				count = param.count;
				
				if(pageNum == 1){
					//처음 호출시, 해당 ID의 div의 내부 내용물을 제거 -> 이 부분이 없으면 이전 댓글과 중복되어 전체 댓글이 나옴
					$('#output').empty();
				}
				
				$(param.list).each(function(index,item){
					let output = '<div class="item">';
					output += '<h4>' + item.id + '</h4>';
					output += '<div class="sub-item">';
					output += '<p>' + item.re_content + '</p>';
					
					if(item.re_modifydate){
						output += '<span class="modify-date">최근 수정일 : ' 
										+ item.re_modifydate + '</span>';
					}else{
						output += '<span class="modify-date">등록일 : ' 
										+ item.re_date + '</span>';
					}
					
					//로그인한 회원번호와 작성자의 회원번호 일치 여부 체크
					if(param.user_num == item.mem_num){
						output += ' <input type="button" data-renum="'+ item.re_num +'" value="수정" class="modify-btn">';
						output += ' <input type="button" data-renum="'+ item.re_num +'" value="삭제" class="delete-btn">';
					}
					output += '<hr size="1" noshade="noshade" width="100%">';
					output += '</div>';
					output += '</div>';
					
					//문서 객체에 추가
					$('#output').append(output);
				});
				
				//page button 처리
				if(currentPage >= Math.ceil(count/rowCount)){
					//다음 페이지가 없음
					$('.paging-button').hide();
				}else{
					//다음 페이지가 존재
					$('.paging-button').show();
				}
			},
			error:function(){
				$('#loading').hide();
				alert('네트워크 오류 발생');
			}
		});
	};
	//페이지 처리 이벤트 연결(다음 댓글 보기 버튼 클릭시 데이터 추가)
	$('.paging-button input').click(function(){
		selectList(currentPage + 1);
	});
	/*===============================
	 * 댓글 등록
	 * ============================== */
	//댓글 등록
	$('#re_form').submit(function(event){
		if($('#re_content').val().trim()==''){
			alert('내용을 입력하세요');
			$('#re_content').val('').focus();
			return false;
		}
		
		//form 이하의 태그에 입력한 데이터를 모두 읽어서 쿼리 스트링으로 반환 
		let form_data = $(this).serialize();
		
		//서버와 통신
		$.ajax({
			url:'writeReply.do',
			type:'post',
			data:form_data,
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인해야 작성할 수 있습니다.');
				}else if(param.result == 'success'){
					//폼 초기화
					initForm();
					//댓글 작성이 성공하면 새로 삽입한 글을 포함해서 첫번째 페이지의 게시글 목록을 다시 호출
					selectList(1); 
				}else{
					alert('댓글 등록 오류');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
		
		//기본 이벤트 제거 - 서버로 폼의 내용이 전송되는 것을 막고 ajax로 통신하기 위함
		event.preventDefault();
	});
	//댓글 작성 폼 초기화
	function initForm(){
		$('textarea').val('');
		$('#re_first .letter-count').text('300/300');
	}
	
	/*===============================
	 * 댓글 등록 및 수정 공통
	 * ============================== */
	//textarea에 내용 입력시 글자수 체크 
	$(document).on('keyup','textarea',function(){
		//입력한 글자수 구함
		let inputLength = $(this).val().length;
		
		if(inputLength > 300){//300자를 넘어선 경우
			$(this).val($(this).val().substring(0,300));
		}else{//300자 이하인 경우
			let remain = 300 - inputLength;
			remain += '/300';
			if($(this).attr('id') == 're_content'){
				//등록폼 글자수
				$('#re_first .letter-count').text(remain);
			}else{
				//수정폼 글자수
				$('#mre_first .letter-count').text(remain);
			}
		}
	});
	
	/*===============================
	 * 댓글 수정
	 * ============================== */
	$(document).on('click','.modify-btn',function(){
		//댓글 번호
		let re_num = $(this).attr('data-renum');
		//댓글 내용       이벤트   바로 위의 부모  태그 찾기  innerHTML 불러오기
		//            수정 버튼   div태그     p태그    
		let content = $(this).parent().find('p').html().replace(/<br>/gi,'\n');
		                                                //g:지정문자열 모두,i:대소문자 무시
		//댓글 수정폼 UI
		let modifyUI = '<form id="mre_form">';
		modifyUI += '<input type="hidden" name="re_num" id="mre_num" value="'+re_num+'">';
		modifyUI += '<textarea rows="3" cols="50" name="re_content" id="mre_content" class="rep-content">'+ content +'</textarea>';
		modifyUI += '<div id="mre_first"><span class="letter-count">300/300</span></div>';
		modifyUI += '<div id="mre_second" class="align-right">';
		modifyUI += ' <input type="submit" value="수정">';
		modifyUI += ' <input type="button" value="취소" class="re-reset">'; 
		modifyUI += '</div>';
		modifyUI += '<hr size="1" noshade="noshade" width="96%">';
		modifyUI += '</form>';
		
		//이전에 이미 수정하는 댓글이 있을 경우 수정버튼을 클릭하면 
		//sub-item 클래스로 지정된 div를 환원시키고 수정폼 제거
		initModifyForm();
		
		
		//수정 버튼을 감싸고 있는 div
		$(this).parent().hide(); //수정버튼이 안 보이게 처리(버튼 삭제 아님)
		
		//수정폼을 수정하고자 하는 데이터가 있는 div에 노출
		//     부모들 중 item클래스 검색
		$(this).parents('.item').append(modifyUI);     
		
		//입력한 글자수 세팅
		let inputLength = $('#mre_content').val().length;
		let remain = 300 - inputLength;
		remain += '/300';
		
		//문서 객체에 반영
		$('#mre_first .letter-count').text(remain);                                          
	});
	
	//댓글 수정폼 초기화
	function initModifyForm(){
		$('.sub-item').show();//작성된 상태의 댓글이 보이게 함
		$('#mre_form').remove();//수정 폼 초기화(삭제)
	};
	
	//수정폼에서 취소버튼 클릭시 수정폼 초기화
	$(document).on('click','.re-reset',function(){
		initModifyForm();
	});
	
	//댓글 수정
	$(document).on('submit','#mre_form',function(event){
		if($('#mre_content').val().trim() == ''){
			alert('내용을 입력하세요.');
			$('#mre_content').val('').focus();
			return false;
		}
		
		//폼에 입력한 데이터 반환
		let form_data = $(this).serialize();
		
		//서버와 통신
		$.ajax({
			url:'updateReply.do',
			type:'post',
			data:form_data,
			dataType:'json',
			success:function(param){
				if(param.result=='logout'){
					alert('로그인 후 수정할 수 있습니다.');
				}else if(param.result=='success'){
					//p태그에 수정된 내용을 가져오기
					//          p태그 접근하기     innerHTML 작성       textarea값 가져오기   "<,>,<br>"특수문자 살려주기
					$('#mre_form').parent().find('p').html($('#mre_content').val().replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/\n/g,'<br>'));
					$('#mre_form').parent().find('.modify-date').text('최근 수정일 : 5초 미만');
					
					
					//수정 폼 삭제 및 초기화
					initModifyForm();
				}else if(param.result=='wrongAccess'){
					alert('타인의 글을 수정할 수 없습니다.')
				}else{
					alert('댓글 수정 오류 발생')
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
		
		//기본 이벤트 제거
		event.preventDefault();
	});
	/*===============================
	 * 댓글 삭제
	 * ============================== */
	//동적으로 작성되었으므로 $('클래스명')으로 작성하지 않음
	$(document).on('click','.delete-btn',function(){
		//댓글번호
		let re_num = $(this).attr('data-renum');
		//서버와 통신
		$.ajax({
			url:'deleteReply.do',
			type:'post',
			data:{re_num:re_num},
			dataType:'json',
			success:function(param){
				if(param.result == 'logout'){
					alert('로그인해야 삭제할 수 있습니다.')
				}else if(param.result == 'success'){
					alert('삭제 완료');
					selectList(1);
				}else if(param.result == 'wrongAccess'){
					alert('타인의 글을 삭제할 수 없습니다.');
				}else{
					alert('댓글 삭제 오류 발생');
				}
			},
			error:function(){
				alert('네트워크 오류 발생');
			}
		});
	});
	
	/*===============================
	 * 초기 데이터(목록) 호출
	 * ============================== */
	selectList(1);
});