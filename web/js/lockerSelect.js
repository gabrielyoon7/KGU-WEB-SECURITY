function Locker(map, lockerWrapClass) {
    let selectLocker = new Array();
    const lockerWrapper = document.querySelector(lockerWrapClass);
    let clicked = "";
    let div = "";

    if(map===mapping1 || map===mapping2|| map===mapping3 || map===mapping4){
        for (let i = 1; i < 5; i++) {
            div = document.createElement("div");
            lockerWrapper.append(div);
            for (let j = 0; j < 2; j++) {
                const input = document.createElement('input');
                input.type = "button";
                input.name = "lockers"
                input.classList = "locker";
                map(input, i, j);
                div.append(input);
                input.addEventListener('click', function(e) {
                    console.log(e.target.value);
                    selectLocker = selectLocker.filter((element, index) => selectLocker.indexOf(element) != index);
                    if (input.classList.contains("clicked")) {
                        input.classList.remove("clicked");
                        clicked = document.querySelectorAll(".clicked");
                        selectLocker.splice(selectLocker.indexOf(e.target.value), 1);
                        clicked.forEach((data) => {
                            selectLocker.push(data.value);
                        });
                    } else {
                        input.classList.add("clicked");
                        clicked = document.querySelectorAll(".clicked");
                        clicked.forEach((data) => {
                            selectLocker.push(data.value);
                        })
                    }
                    console.log(selectLocker);
                })
            }
        }
    }
    else if(map===mapping5){
        for (let i = 1; i < 4; i++) {
            div = document.createElement("div");
            lockerWrapper.append(div);
            for (let j = 0; j < 3; j++) {
                const input = document.createElement('input');
                input.type = "button";
                input.name = "lockers"
                input.classList = "locker";
                map(input, i, j);
                div.append(input);
                input.addEventListener('click', function(e) {
                    console.log(e.target.value);
                    selectLocker = selectLocker.filter((element, index) => selectLocker.indexOf(element) != index);
                    if (input.classList.contains("clicked")) {
                        input.classList.remove("clicked");
                        clicked = document.querySelectorAll(".clicked");
                        selectLocker.splice(selectLocker.indexOf(e.target.value), 1);
                        clicked.forEach((data) => {
                            selectLocker.push(data.value);
                        });
                    } else {
                        input.classList.add("clicked");
                        clicked = document.querySelectorAll(".clicked");
                        clicked.forEach((data) => {
                            selectLocker.push(data.value);
                        })
                    }
                    console.log(selectLocker);
                })
            }
        }
    }
    else if(map===mapping6){
        for (let i = 1; i < 5; i++) {
            div = document.createElement("div");
            lockerWrapper.append(div);
            for (let j = 0; j < 3; j++) {
                const input = document.createElement('input');
                input.type = "button";
                input.name = "lockers"
                input.classList = "locker";
                map(input, i, j);
                div.append(input);
                input.addEventListener('click', function(e) {
                    console.log(e.target.value);
                    selectLocker = selectLocker.filter((element, index) => selectLocker.indexOf(element) != index);
                    if (input.classList.contains("clicked")) {
                        input.classList.remove("clicked");
                        clicked = document.querySelectorAll(".clicked");
                        selectLocker.splice(selectLocker.indexOf(e.target.value), 1);
                        clicked.forEach((data) => {
                            selectLocker.push(data.value);
                        });
                    } else {
                        input.classList.add("clicked");
                        clicked = document.querySelectorAll(".clicked");
                        clicked.forEach((data) => {
                            selectLocker.push(data.value);
                        })
                    }
                    console.log(selectLocker);
                })
            }
        }
    }
};

function mapping1(input, i, j) {
    if (i === 1) {
        input.value = j+1;
    } else if (i === 2) {
        input.value = j+3;
    } else if (i === 3) {
        input.value = j+5;
    } else if (i === 4) {
        input.value = j+7;
    }
}
function mapping2(input, i, j) {
    if (i === 1) {
        input.value = j+9;
    } else if (i === 2) {
        input.value = j+11;
    } else if (i === 3) {
        input.value = j+13;
    } else if (i === 4) {
        input.value = j+15;
    }
}
function mapping3(input, i, j) {
    if (i === 1) {
        input.value = j+17;
    } else if (i === 2) {
        input.value = j+19;
    } else if (i === 3) {
        input.value = j+21;
    } else if (i === 4) {
        input.value = j+23;
    }
}
function mapping4(input, i, j) {
    if (i === 1) {
        input.value = j+25;
    } else if (i === 2) {
        input.value = j+27;
    } else if (i === 3) {
        input.value = j+29;
    } else if (i === 4) {
        input.value = j+31;
    }
}
function mapping5(input, i, j) {
    if (i === 1) {
        input.value = j+1;
    } else if (i === 2) {
        input.value = j+4;
    } else if (i === 3) {
        input.value = j+7;
    } else if (i === 4) {
        input.value = j+10;
    }
}
function mapping6(input, i, j) {
    if (i === 1) {
        input.value = j+33;
    } else if (i === 2) {
        input.value = j+39;
    } else if (i === 3) {
        input.value = j+45;
    } else if (i === 4) {
        input.value = j+51;
    }
}
window.onload = function init(){
    Locker(mapping1, ".locker-wrapper-1");
    Locker(mapping2, ".locker-wrapper-2");
    Locker(mapping3, ".locker-wrapper-3");
    Locker(mapping4, ".locker-wrapper-4");
    Locker(mapping5, ".locker-wrapper-5");
    Locker(mapping6, ".locker-wrapper-6");
}