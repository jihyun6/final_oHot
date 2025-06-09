<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.15/jstree.min.js"></script>
    <link rel="stylesheet" href="//static.jstree.com/3.3.15/assets/bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.3.15/themes/default/style.min.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/1.8.4/axios.min.js"></script>
</head>
<body>

<div id="jstree"></div>
<input type="text" id="schName" value="">
<button onclick="fSch()">탐색</button>
<script>
    $('#jstree').on("ready.jstree", function (e, data) {
    console.log("트리 준비 완료!", data.instance.get_json());
    });

    //껌색
    function fSch() {
        console.log("껌색할께영");
        $('#jstree').jstree(true).search($("#schName").val());
    }

    //중요 속성, original, icon, state
    // root node는 parent를 #

    //Default 설정 바꾸깅, 아래를 주석 처리해보면 모양이 어케 바뀔깡?
    $.jstree.defaults.core.themes.variant = "large";

    //맹글기, 옵션없이(디폴트 옵션으로, 요렇게는 잘 안씀)
    //$("#jstree").jstree();   // creates an instance
    //$('#tree2').jstree(true); // get an existing instance (will not create new instance)

    //일반적으로 요렇게만 사용해도 충분!
    $("#jstree").jstree({
        "plugins": ["search"],
        'core': {
            'data': {
                "url": function (node) {

                    axios.get("/emp/treeListAjax").then(resp =>{
                      console.log("조직도!@! : ", resp.data);
                })
                    return "/emp/treeListAjax"; // ajax로 요청할 URL
                }
                /*,
                "data": function (node) {
                    return { 'id': node.id }  // ajax로 보낼 데이터(없어서 주석)
                }
                */,
                "dataType" : "json"
            },
            "check_callback": true,  // 요거이 없으면, create_node 안먹음
        }
    });


    /* 보통은 위 방식으로 충분하지만, 좀더 세밀한 제어를 하고 싶다면, 
       직접 ajax구현 및 데이터 조작후 callback함수 cb를 이용하여 data세팅
    $("#jstree").jstree({
        "plugins": ["search"],
        'core': {
            'data': function (obj, cb) {
                console.log("ck1:", obj,this);

                let xhr = new XMLHttpRequest();
                xhr.open("get", "alldata.json", true);
                xhr.onreadystatechange = function () {
                    if (xhr.readyState == 4 && xhr.status == 200) {
                        console.log(xhr.responseText);
                        cb.call(obj, JSON.parse(xhr.responseText));
                        $('#jstree').jstree(true)
                    }
                }
                xhr.send();
            },
           "check_callback": true  // 요거이 없으면, create_node 안먹음
        }
    });
    */



    //이벤트
    $('#jstree').on("changed.jstree", function (e, data) {
        console.log(data.selected);
    });

    // Node 열렸을 땡
    let isAdded = false;
    $('#jstree').on("open_node.jstree", function (e, data) {
        console.log("open되었을땡", data.node);

        // 자식 NODE 맹글기, NODE ID S22(MES)가 열렷을 때
        // 한번만 김지은 추가하는 예제, 메소드 리스트에서 create_node검색
        if (!isAdded && data.node.id == 'S22') {
            let myNode = {
                "text": "김영신",
                "id": "J09",
                "whoisshe": "actress",
                "isBestFriend": "Y",
                "icon": "glyphicon glyphicon-user"
            };
            let myCallBack = () => {
                alert("추가했어용");
            }
            // NODE 추가
            $('#jstree').jstree(true).create_node('S22', myNode, "last", myCallBack);
            isAdded = true;
        }

    });

    // Node 선택했을 땡
    $('#jstree').on("select_node.jstree", function (e, data) {
        console.log("select했을땡", data.node);

        const node = data.node;
    });


    /* 상호작용, 버젼 호환성을 위해 같은 기능에 3가지 표현이 존재한당. 그냥 우에껄 쓰장!
      $('#jstree').jstree(true).select_node('child_node_1');
      $('#jstree').jstree('select_node', 'child_node_1');
      $.jstree.reference('#jstree').select_node('child_node_1');
    */	
	
</script>
</body>
</html>