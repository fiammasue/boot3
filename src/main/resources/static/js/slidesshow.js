let slides = document.querySelectorAll("#slides > img");
let prev = document.getElementById("prev");
let next = document.getElementById("next");

let current =0;

showSlides(current);
prev.onclick = prevSlide;
next.onclick = nextSlide;

function showSlides(n){
    for(let i=0;i<slides.length;i++){
        //모든 이미지를 화면에서 안보이게
        slides[i].style.display="none";
    }
    //n번째 이미지만 화면에 표시
    slides[n].style.display="block";
}
function prevSlide(){
    if(current>0)current -= 1;//현재위치가 0보다크면 이전위치로
    else current = slides.length-1;//아니면 다시 맨뒤에서 부터 시작
    showSlides(current);//이미지 표시
}
function nextSlide(){
    if(current<slides.length-1)current+=1;//현재값이 전체인덱스보다 작다면 다음위치
    else current=0;//크다면 처음으로 돌린다.
    showSlides(current);

}