<%@ WebHandler Language="C#" Class="ThumbnailHandler" %>

using System;
using System.Web;

public class ThumbnailHandler : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        System.Data.SqlClient.SqlDataReader rdr = null;
        System.Data.SqlClient.SqlConnection conn = null;
        System.Data.SqlClient.SqlCommand sqlcmd = null;
        try
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            conn = new System.Data.SqlClient.SqlConnection(connectionString);
            conn.Open();
            sqlcmd = new System.Data.SqlClient.SqlCommand("select PostContent, PostContentType from UserPosts where PostId='" + new Guid( context.Request.QueryString["postid"]) + "'", conn); 
            rdr = sqlcmd.ExecuteReader();
            while (rdr.Read())
            {
                //context.Response.ContentType = "image/jpg";
                //context.Response.BinaryWrite((byte[])rdr["ProfilePicture"]);
                System.IO.MemoryStream ms = new System.IO.MemoryStream((byte[])rdr["PostContent"]);
                System.Drawing.Image image = System.Drawing.Image.FromStream(ms);
                // create the actual thumbnail image
                System.Drawing.Image thumbnailImage = image.GetThumbnailImage(200, 200, new System.Drawing.Image.GetThumbnailImageAbort(ThumbnailCallback), IntPtr.Zero);

                // make a memory stream to work with the image bytes
                System.IO.MemoryStream imageStream = new System.IO.MemoryStream();

                // put the image into the memory stream
                thumbnailImage.Save(imageStream, System.Drawing.Imaging.ImageFormat.Jpeg);

                // make byte array the same size as the image
                byte[] imageContent = new Byte[imageStream.Length];

                // rewind the memory stream
                imageStream.Position = 0;

                // load the byte array with the image
                imageStream.Read(imageContent, 0, (int)imageStream.Length);

                // return byte array to caller with image type
                context.Response.ContentType = rdr["PostContentType"].ToString();
                context.Response.BinaryWrite(imageContent);

            }
            if (rdr != null)
                rdr.Close();
        }
        catch { }


        finally
        {
            if (conn != null)
                conn.Close();
        }
    }
    public bool ThumbnailCallback()
    {
        return true;
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}