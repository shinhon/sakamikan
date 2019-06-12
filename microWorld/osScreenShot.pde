import java.awt.AWTException;
import java.awt.Robot;
import java.awt.event.InputEvent;
import java.awt.event.KeyEvent;

void screenShot(){
  try{
    Robot c = new Robot();
    c.keyPress(KeyEvent.VK_META);
    c.keyPress(KeyEvent.VK_SHIFT);
    c.keyPress(KeyEvent.VK_3);
    c.keyRelease(KeyEvent.VK_3);
    c.keyRelease(KeyEvent.VK_SHIFT);
    c.keyRelease(KeyEvent.VK_META);
  }
  catch(AWTException e){
    println(e);
  }
}
