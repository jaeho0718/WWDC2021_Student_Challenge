//#-hidden-code
playSound(true)
GameInit()
checkUserInput("AddBlock",pass_message:"We now learn If condition.",fail_hint:["Use AddBlock(to:,delay:)!!"],nextPageName:"Conditional-2")
//#-end-hidden-code
/*:
 # **If conditional**
 
 **Goal : Judge score!**
 
 In game, Score is important. Now we make score comment according to Score.(When you touch the block appeared, Score is up.)
 
 For exampe, if socre is bigger than 10, set scorecomment is 'A'.
 To judge Score, We have to learn relational operator.
 
 ### Relatrional operator
 
 A == B : If A=B,it is true.
 
 A != B : If A is not equal to B,it is true.
 
 A > B : If A is bigger than B,it is true.
 
 A >= B : If A is equlal or bigger than B,it is true.
 

    if (condition){
        //If condition is true, command in brace run
    }else{
        //If condition is false,command in brace run
    }

 Use **setScoreLabel(socre:,comment:)** to set score comment.
 
    setScoreLabel(score:"A",comment:"Great!!")
    //When game is end, score is appear on screen.
    
 */
//make block!!
//#-editable-code make Block!
//#-end-editable-code
setEndingScene({ score in
    // setEndingScene deliver score value to you.
    // So you can check score using score value
    if /*#-editable-code criteria*/score > 5/*#-end-editable-code*/ {
        return setScoreLabel(score:/*#-editable-code Score*/"A"/*#-end-editable-code*/,comment:/*#-editable-code Score Comment*/"Great!!"/*#-end-editable-code*/)
    }else{
        return setScoreLabel(score:/*#-editable-code Score*/"C"/*#-end-editable-code*/,comment:/*#-editable-code Score Comment*/"Opps😱"/*#-end-editable-code*/)
    }
    
})

