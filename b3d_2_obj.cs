// файлы GOBELIN, TEMPLE6, TOWN с ошибками в количестве сабмешей и вершин

//ææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææ
  using System; using System.IO; using System.Linq; using System.Text; using System.Collections; 
  using System.Collections.Generic; using System.Text.RegularExpressions; using System.Globalization; 
//ææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææ

sealed class Test
{
    static uint vertexCount; 
    static uint faceCount;

    public static void Main()
    {
        SearchOption SOAD = SearchOption.AllDirectories;
        string[] filesName = Directory.GetFiles(Directory.GetCurrentDirectory(), "*.b3d",  SOAD); 
        System.Threading.Thread.CurrentThread.CurrentCulture = new CultureInfo("en-US");

        foreach (var fileIn in filesName)
        {
						using (BinaryReader br = new BinaryReader(File.Open(fileIn, FileMode.Open)))
						{
                int submesh_count = br.ReadInt32(); 
                    
                for (int o = 0; o < submesh_count; o++)
                {
                    using (StreamWriter sw = new StreamWriter(fileIn + o + ".obj"))
                    {
                        O3dModel o3d = new O3dModel();

                        uint type = br.ReadUInt32();  

                        br.ReadBytes(8); 
                        br.ReadBytes(48); 
                        for(int i = 0; i < 6; i++) br.ReadSingle(); 
                        
                        vertexCount = br.ReadUInt32(); 
                        faceCount   = br.ReadUInt32(); 
                        uint faceCount2   = br.ReadUInt32(); 
                        uint vertexCount1 = br.ReadUInt32(); 

                        for(int i = 0; i < vertexCount; i++) 
                        {
                            o3d_vertex newv = new o3d_vertex();
                            newv.x = br.ReadSingle();
                            newv.y = br.ReadSingle();
                            newv.z = br.ReadSingle();
                            o3d.vertexes.Add(newv);
                        }

                        for(int i = 0; i < faceCount; i++) 
                        {
                            o3d_face newf = new o3d_face();

                            br.ReadByte();
                            br.ReadByte();
                            br.ReadByte();
                            br.ReadByte();

                            br.ReadSingle();
                            br.ReadSingle();
                            br.ReadSingle();
                            br.ReadSingle();
                            br.ReadSingle();
                            br.ReadSingle();
                            br.ReadSingle();
                            br.ReadSingle();

                            for (int ii = 0; ii < 4; ii++) 
                            {
                                newf.index[ii] = br.ReadUInt16();
                            }
                            o3d.faces.Add(newf); 
                            
                            br.ReadUInt16();
                            br.ReadUInt16();
                            br.ReadUInt16();
                        }

// ======================================================== 

                        foreach (var v in o3d.vertexes)
                        sw.WriteLine("v " + v.x + " " + v.y + " " + v.z);

                        var enumerator = o3d.faces.GetEnumerator();

                        foreach (var v in o3d.faces)
                        {
                            if (v.index[0] == 65535 || v.index[1] == 65535 || v.index[2] == 65535 ) enumerator.MoveNext();
                            sw.WriteLine("f " + (v.index[0]+1) + " " + (v.index[1]+1) + " " + (v.index[2]+1));
                            if (v.index[3] != 65535) sw.WriteLine("f " + (v.index[0]+1) + " " + (v.index[2]+1) + " " + (v.index[3]+1));
                        }
                    
                    }
                }
            }
        } // foreach (var file in filesName)
    } // public static void Main()
} // sealed class Test {

//ææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææ
//ææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææ
//ææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææææ

public class O3dModel
{
    public List<o3d_vertex> vertexes = new List<o3d_vertex>();
    public List<o3d_face>   faces = new List<o3d_face>();
}

// ======================================================== 

public class o3d_vertex 
{
  public float x, y, z; // Model vertex position (XYZ)
}

// ======================================================== 
 
public class o3d_face // ãðàíü/ïîëèãîí (òðåóãîëüíèê èëè ÷åòûðåõóãîëüíèê)
{
  public ushort[] index = new ushort[4];
}
