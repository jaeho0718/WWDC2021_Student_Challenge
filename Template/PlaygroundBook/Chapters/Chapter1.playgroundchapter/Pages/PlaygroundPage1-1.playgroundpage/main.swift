//#-hidden-code
playSound(false)
showScore(false)
GameInit()
checkUserInput("AddBlock",pass_message:"Great!, You made Block.",fail_hint:["Use AddBlock(to:,delay:)!!"],nextPageName:"Function")
//#-end-hidden-code
/*:
 # **Make Box!**
 
 **Goal : Make blocks appear three times repeatedly on Tap1,Tap5,Tap9.**
 
 In **Let's Start Page** we made one Block, but we need many blocks in Rhythm game.
 Now Make many Blocks.
 
 When you use **AddBlock(to:)** many times, you can see the Blocks appear at the same time.
 To prevent this problem, We can use **AddBlock(to: ,delay: )**
 
    AddBlock(to:1,delay:3)
    //The block appear in Tap1 after 3seconds.
 
 
 music will be played from page 4.
 */


