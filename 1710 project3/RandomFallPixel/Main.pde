
class Main{
    public Configure confs; 
    public PixelMatrix pixelMatrix; 
    public PictureFill picFill;    
    private PVector sizeImg;  
    private int waitUpdate;  
    private int countUpdate; 
    private PVector followUpdate;  
    private int numUpdateOnce;  
    Main(){
        IniMain();
    }
    
    public void IniMain(){
        confs = new Configure();
        pixelMatrix = new PixelMatrix();
        pixelMatrix.IniPixelMatrix( confs );
        picFill = new PictureFill( pixelMatrix.GetMatrixSize(), pixelMatrix.GetShowStart() );
        sizeImg = pixelMatrix.GetMatrixSize();
        waitUpdate = confs.waitUpdate;
        numUpdateOnce = max( 1, confs.numUpdateOnce);
    }

    public void Ready(){
        pixelMatrix.PointsGotoStart();
        pixelMatrix.SetPointsTarget();
        countUpdate = 0;
        if( waitUpdate <= 0 ){
            followUpdate = new PVector( 0, 0 );
            pixelMatrix.SetUpdateEnable();
        }
        else{
            followUpdate = new PVector( sizeImg.x-1, sizeImg.y-1 );
        }
    }

    public void Run(){
        picFill.ShowImg();
        picFill.Update( pixelMatrix.Update() );
        if( followUpdate.x <= 0 && followUpdate.y <= 0 ){
            return;
        }
        SetUpdateEnable( GetNextUpdateIndex() );
    }

    public void SetUpdateEnable( PVector[] tPointUpdate ){
        if( tPointUpdate == null || tPointUpdate.length <= 0 ){
            return;
        }
        for( int k=0; k<tPointUpdate.length; k++ ){
            pixelMatrix.SetUpdateEnable( int(tPointUpdate[k].x), int(tPointUpdate[k].y) );
        }
    }
    

    public PVector[] GetNextUpdateIndex(){
        PVector[] tOuts = new PVector[]{};
        if( countUpdate >= waitUpdate ){
            tOuts = new PVector[numUpdateOnce];
            for( int h=0; h<numUpdateOnce; h++  ){
                 tOuts[h] = GetFollowUpdate();
            }
            countUpdate = 0;
        }
        else{
            countUpdate += 1;
        }
        return tOuts;
    }

    public PVector GetFollowUpdate(){
            followUpdate.x -= 1;
            if( followUpdate.x < 0 ){
                followUpdate.y -= 1;
                followUpdate.x = sizeImg.x-1;
            }
            
        if( followUpdate.y < 0 ){
            followUpdate = new PVector( 0, 0 );
        }
        return followUpdate.copy();
    }
  
}
