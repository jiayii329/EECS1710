//单个像素点

class PixelOne{
    public PVector pointImg; //坐标(在图片里的位置)
    public color[] colorRGB;  //颜色(移动中+到达目的点)
    public int[] colorAlpha;  //透明度(移动中+到达目的点)
    public PVector[] size; //大小(移动中+到达目的点)
    public PVector pointNow; //坐标(当前)
    public PVector pointTarget; //坐标(目标)
    public PVector speedNow; //当前的速度
    public PVector acceleration; //加速度
    public float accelerationSet; //设置加速度
    private int moveProgress;  //进度
    
    PixelOne(){
        
    }
    
    PixelOne( PVector tPoint, PVector[] tSizes, float tAccelerationSet ){
        SetPixel( tPoint, tSizes, tAccelerationSet );
    }
    
    //设置Pixel
    public void SetPixel( PVector tPoint, PVector[] tSizes, float tAccelerationSet ){
        pointImg = tPoint.copy();
        pointNow = tPoint.copy();
        pointTarget = tPoint.copy();
        size = new PVector[]{ tSizes[0].copy(), tSizes[1].copy() };
        accelerationSet = tAccelerationSet;
        speedNow = new PVector();
    }
    //设置颜色
    public void SetColors( color tColorMove, int tAlphaMove, color tColorTarget, int tAlphaTarget ){
        colorRGB = new color[]{ tColorMove, tColorTarget };
        colorAlpha = new int[]{ tAlphaMove, tAlphaTarget };
    }
    //设置加速度
    public void SetAcceleration( float tAcceleration ){
        accelerationSet = tAcceleration;
    }
    
    //设置目标坐标
    public void SetPointTarget( PVector tPointTarget, boolean tSpeedUp ){
        moveProgress = 0;
        pointTarget = tPointTarget.copy();
        
        acceleration = PVector.sub( pointTarget,pointNow );
        acceleration.normalize();
        if( tSpeedUp == true ){
            acceleration.mult( accelerationSet );
            speedNow = new PVector( 0, 0 );
        }
        else{
            acceleration.mult( -1.0*accelerationSet );
            speedNow.x = sqrt( 2.0*abs(acceleration.x*(pointTarget.x-pointNow.x)) )*(pointTarget.x>pointNow.x?1:-1);
            speedNow.y = sqrt( 2.0*abs(acceleration.y*(pointTarget.y-pointNow.y)) )*(pointTarget.y>pointNow.y?1:-1);
        }

    }
    
    //设置直接跳转到某个坐标
    public void SetPointGoto( PVector tPointTarget ){
        moveProgress = 0;
        pointNow = tPointTarget.copy();
        pointTarget = tPointTarget.copy();
    }
    
    //更新状态
    public int Update(){
        if( moveProgress >= 2 ){
            return moveProgress;
        }
        else if( moveProgress == 1 ){
            moveProgress ++;
            return moveProgress;
        }
        else if( PVector.dist(pointTarget, pointNow) <= max(1,PVector.dist(speedNow,new PVector())/1.0) ){
            moveProgress = 1;
            pointNow = pointTarget.copy();
        }
        else{
            pointNow.add( speedNow );
            speedNow.add( acceleration );
        }

        noStroke();
        fill( colorRGB[moveProgress], colorAlpha[moveProgress] );
        rect( pointNow.x, pointNow.y, size[moveProgress].x, size[moveProgress].y);
        
        return moveProgress;
    }
    
    //获取颜色
    public color GetColorNow(){
        return colorRGB[moveProgress];
    }
}
