//#-hidden-code
playSound(false)
showScore(false)
GameInit()
checkUserInput("AddBlock",pass_message:"Great!, You made for loop.",fail_hint:["Use AddBlock(to:,delay:)!!"],nextPageName:"Conditional-1")

//#-end-hidden-code
/*:
 # **For loop**
 
 **Goal : Placing blocks using loops.**
 
 In **Function Page**,you wrote own function. If you want to show the block on Tap1,Tap5,Tap9, you just call function that you define in previous step.
 
 But When you want to appear 8times repetitively the block on Tap1,Tap5,Tap9, How can we do? Call function 9times?. Nope. Computer are good at repitive tasks. So we don't need to write same code several times to do repetitive tasks, when we use **For Loop**.
 
 Now Let's make code using funtion and for loop.
 
    for i in 1...number of repetitions {
        //command
    }
 
 music will be played from page 4.
 */

//#-editable-code make function

//#-end-editable-code

for i in 1 ... /*#-editable-code number of repetitions*/1/*#-end-editable-code*/ {
    //#-editable-code put in your function that parameter is delay and put i in delay(parameter)
    
    //#-end-editable-code
}
