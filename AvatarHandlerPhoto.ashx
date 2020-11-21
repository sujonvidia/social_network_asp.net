<%@ WebHandler Language="C#" Class="CovertHandler" %>

using System;
using System.Web;

public class CovertHandler : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        System.Data.SqlClient.SqlDataReader rdr = null;
        System.Data.SqlClient.SqlConnection conn = null;
        System.Data.SqlClient.SqlCommand sqlcmd = null;

        try
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["SecurityConnectionString"].ConnectionString;
            conn = new System.Data.SqlClient.SqlConnection(connectionString);

            sqlcmd = new System.Data.SqlClient.SqlCommand("select Avatar from PhotoStore where PhotoID='" + context.Request.QueryString["id"] + "'", conn);
            conn.Open();
            rdr = sqlcmd.ExecuteReader();
            while (rdr.Read())
            {

                context.Response.BinaryWrite((byte[])rdr["Avatar"]);

            }
            if (rdr != null)
                rdr.Close();
        }
        catch (Exception ex)
        {
            
        }

        finally
        {
            if (conn != null)
                conn.Close();
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}