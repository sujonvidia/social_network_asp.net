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

            sqlcmd = new System.Data.SqlClient.SqlCommand("select CoverPicture from UserProfiles where UserId='" + context.Request.QueryString["userid"] + "'", conn);
            conn.Open();
            rdr = sqlcmd.ExecuteReader();
            while (rdr.Read())
            {
                //context.Response.ContentType = "image/jpg";
                //context.Response.BinaryWrite((byte[])rdr["ProfilePicture"]);
                System.IO.MemoryStream ms = new System.IO.MemoryStream((byte[])rdr["CoverPicture"]);
                System.Drawing.Image image = System.Drawing.Image.FromStream(ms);
                // create the actual thumbnail image
                System.Drawing.Image thumbnailImage = image.GetThumbnailImage(2000, 1000, new System.Drawing.Image.GetThumbnailImageAbort(ThumbnailCallback), IntPtr.Zero);

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
                context.Response.ContentType = "image/jpeg";
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