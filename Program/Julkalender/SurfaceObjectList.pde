public class SurfaceObjectList extends TuiObjectList
{
  void activate(Integer s_id, Integer f_id) 
  { 
    TuiObject nobj = new SurfaceObject(s_id.intValue(), f_id.intValue(),"ellipse",color(255,0,0),40);
    objectList.put(s_id,nobj);
  }
}
