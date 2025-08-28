class JoyPad{
  private boolean upPressed;
  private boolean downPressed;
  private boolean rightPressed;
  private boolean leftPressed;
  
  public boolean isUpPressed(){
    return this.upPressed;
  }
  public void setUpPressed(boolean upPressed){
    this.upPressed = upPressed;
  }
  
  public boolean isDownPressed(){
    return this.downPressed;
  }
  public void setDownPressed(boolean downPressed){
    this.downPressed = downPressed;
  }
  
    public boolean isRightPressed(){
    return this.rightPressed;
  }
  public void setRightPressed(boolean rightPressed){
    this.rightPressed = rightPressed;
  }
  
  public boolean isLeftPressed(){
    return this.leftPressed;
  }
  public void setLeftPressed(boolean leftPressed){
    this.leftPressed = leftPressed;
  }  
}
