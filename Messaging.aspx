<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage2.master" AutoEventWireup="true" CodeFile="Messaging.aspx.cs" Inherits="Default2" Async="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    
    <style type="text/css">
        #top_menu{
            display:none;
        }

   .inlineBlock { float:left }
   .toptext{
       vertical-align:top;
   }
   .replypadding{
       padding:10px;
       padding-bottom:25px;
       background-color:gray;
   }
</style>
    <script type="text/javascript">
        function scrollPanelToBottom() {
            var panel = document.getElementById('<%=PanelMessageBox.ClientID %>');
        panel.scrollTop = panel.scrollHeight;
    }
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   <%-- <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>--%>
    <script type="text/javascript">
        var prm = Sys.WebForms.PageRequestManager.getInstance();
        prm.add_beginRequest(beginRequest);
        function beginRequest() {
            prm._scrollPosition = null;
        }
</script>
    <script type="text/javascript">
        var xPos, yPos;
        var prm = Sys.WebForms.PageRequestManager.getInstance();
        prm.add_beginRequest(BeginRequestHandler);
        prm.add_endRequest(EndRequestHandler);
        function BeginRequestHandler(sender, args) {
            xPos = $get('scrollDiv').scrollLeft;
            yPos = $get('scrollDiv').scrollTop;
        }
        function EndRequestHandler(sender, args) {
            $get('scrollDiv').scrollLeft = xPos;
            $get('scrollDiv').scrollTop = yPos;
        }
</script>
    <div style="margin-top: 43px;width: 960px;height:100vh;background-color:white;position:fixed;margin-left: 8px;">
            <table runat="server">
        <tr>
            <td style="vertical-align:top;background-color: white;padding: 15px;border-radius: 10px 0px 0px 10px;">
                <asp:DataList ID="DataList1" ItemStyle-Wrap="true"  runat="server" CellPadding="0" OnItemDataBound="DataList1_ItemDataBound" OnItemCommand="DataList1_ItemCommand" DataSourceID="FriendDataSource1" style="color:#333333;width: 367px;border-collapse:collapse;">
        
        <%--<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <ItemStyle  BackColor="White" />--%>
        <ItemTemplate >
           <button id="frd" type="button" onserverclick="frd_ServerClick" onmouseover="this.style.backgroundColor='gray'" onmouseout="this.style.backgroundColor='white'" runat="server" style="cursor: pointer; text-align: left; border-width: 1px; border-style: solid; background-color: white;width: 365px;" value='<%# Eval("UserId").ToString() %>'>
      
               <table runat="server">
                   <tr>
                   <td style="padding:5px;">
                <asp:Image ID="ImageProfile" runat="server" Width="50px" Height="50px" ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("UserId") %>' />
               </td>
               
                           <td >
               <asp:Label ID="FullNameLink" Width="150" Height="10" runat="server" Text='<%# Eval("FirstName") %>'/>  
                               </td>
                       </tr>
                   </table>
                       
            </button>
        </ItemTemplate>
               <%--     <SeparatorTemplate> <hr /></SeparatorTemplate>--%>
  <%--      <SelectedItemStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />--%>
    </asp:DataList>
            </td>
            <td style="vertical-align:top">
                    <asp:Timer ID="Timer1" runat="server" Interval="1000" ClientIDMode="AutoID">
</asp:Timer> 
                 
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
         
        <ContentTemplate>
             
                <asp:Panel ID="PanelMessageBox" runat="server" Width="545px" Height="300px"  ScrollBars="Vertical" HorizontalAlign="Left" BackColor="white">
                    <asp:DataList ID="DataListMsgBox" runat="server" DataSourceID="MsgboxDataSource1" Width="550px">
                        <ItemTemplate>
                              <div style="border-bottom-width:1px;border-bottom-style:solid;border-bottom-color:gray">
<%--                        <asp:Image ID="ImageProfile" runat="server" Width="50px" Height="50px" ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("UserId") %>' />--%>
                           <%-- <asp:Label ID="FullNameLabel" runat="server" Text='<%# Eval("FullName") %>' />--%>
                               <div style="margin:5px;float:left;">
                                  
                                
                                    <asp:Image ID="Image1" runat="server" Width="50" Height="50" ImageUrl='<%# "ThumbnailHandlerProfile.ashx?userid=" + Eval("Message_from_id") %>' />
                           </div>
                                    <table runat="server" style="float:left;">
                             <tr>
                                 <td>
                                 <asp:Label ID="Label1" ForeColor="Blue" Font-Size="Medium" runat="server" Text='<%# Eval("Message_from_name") %>' CssClass="toptext" />
                                     </td>
                             </tr>
                             <tr><td>
                                    <asp:Label ID="MessageLabel" runat="server" Text='<%# Eval("Message") %>' CssClass="toptext" />
                                 </td>
                             </tr>
                         </table>
                                    
                                
                                <div style="position:relative;float:right">
                                <asp:Label ID="Label2" runat="server" Text='<%# Eval("Message_date") %>' />
                                    </div>
                      </div>
                        </ItemTemplate>
                    </asp:DataList>
                    <asp:SqlDataSource ID="MsgboxDataSource1" runat="server" OnSelecting="MsgboxDataSource1_Selecting" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" 
                        SelectCommand="SELECT * FROM [Messaging] where Message_to=@Message_to and Message_from=@Message_from ORDER BY Message_date">
                        <SelectParameters>
                            <asp:Parameter Name="Message_to" Type="Object" />
                           <asp:Parameter Name="Message_from" Type="Object" />
                        </SelectParameters>
                    </asp:SqlDataSource>
        </asp:Panel>
             
             </ContentTemplate>
    </asp:UpdatePanel>
            
               <asp:Panel ID="PanelMessageReply" runat="server" style="vertical-align:bottom;margin-left: 0px;margin-top: 20px;" CssClass="footermsg" >
            <asp:TextBox ID="txtMessage" runat="server" Columns="40" Height="85px" TextMode="MultiLine" Width="535px" EnableViewState="False" BorderWidth="1px"></asp:TextBox>
        <div >
             <asp:FileUpload ID="FileUpload1" runat="server" />
            <asp:Button ID="btnReply" runat="server" OnClick="btnReply_Click" Text="Reply" style="width:52px;background-color: #26284F;color: white;padding: 2px;margin-left: 220px;" EnableViewState="False" />
                 </div>
        </asp:Panel>
            </td>
        </tr>
    </table>
        </div>
            <asp:SqlDataSource ID="FriendDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" SelectCommand="SELECT UserProfiles.UserId, UserProfiles.FullName, UserProfiles.FirstName, UserProfiles.ProfilePicture FROM UserProfiles INNER JOIN FriendsList ON UserProfiles.UserId = FriendsList.friend_id WHERE (FriendsList.my_id = @my_id)" OnSelecting="FriendDataSource1_Selecting">
        <SelectParameters>
            <asp:Parameter Name="my_id" />
        </SelectParameters>
    </asp:SqlDataSource>
       
    
    
     
    
        

    
    
        
</asp:Content>

