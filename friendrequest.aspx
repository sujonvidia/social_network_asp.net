<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage2.master" AutoEventWireup="true" CodeFile="friendrequest.aspx.cs" Inherits="Default2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link rel="stylesheet" type="text/css" href="css/master.css"/>
    <style>
        #top_menu{
            display:none;
          
        }
        #page{
            background-color:white;
        }
        #page_position_content{
    margin-top: -28px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder_top_menu" Runat="Server" style="display:none" />
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Always" ChildrenAsTriggers="true" style="margin-left: 0px;margin-top: 70px;background-color:white;width: 960px;
	min-height: 1226.6666666666674px;">
               
               <ContentTemplate>
       
                   <asp:Panel ID="pnNotifications" runat="server" CssClass="popup" style="
    background: #EFF3FB;
">
               
               <asp:DataList ID="DataList1" runat="server" OnItemCreated="DataList1_ItemCreated" OnItemCommand="DataList1_ItemCommand" CellPadding="4" DataKeyField="Request_from" DataSourceID="FriendDataSource1" ForeColor="#333333" Width="774px">
                   <SeparatorTemplate>
                       <hr />
                   </SeparatorTemplate>
                   <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                   <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                   <ItemStyle BackColor="#EFF3FB" />
                   <ItemTemplate>
                       
                       <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' Visible="false" />
                                    
                       <asp:Label ID="Request_fromLabel" runat="server" Text='<%# Eval("Request_from") %>' Visible="false" />
                                          
                       <asp:Label ID="Request_toLabel" runat="server" Text='<%# Eval("Request_to") %>' Visible="false" />
                       <asp:Image ID="ImageProfile" runat="server" Width="50px" Height="50px" ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("Request_from") %>' />
                       <asp:Label ID="FullNameLabel" runat="server" />
                       <asp:Button ID="ButtonReqAccept" CommandName="CommandAccept" runat="server" Text="Accept" style="height: 30px;width: 70px;background-color: #26284f;color: white;margin-bottom: 5px;" />
                       <asp:Button ID="ButtonReqReject" CommandName="CommandReject" runat="server" Text="Reject" style="height: 30px;width: 70px;background-color: #26284f;color: white;margin-bottom: 5px;" />
                       <asp:Label ID="LabelNotify" runat="server" Text="Request Accepted" Visible="false"></asp:Label>
                       <br />
                      
                       <asp:Label ID="Request_statusLabel" runat="server" Text='<%# Eval("Request_status") %>' Visible="false" />
                       <br />
                       Request_date:
                       <asp:Label ID="Request_dateLabel" runat="server" Text='<%# Eval("Request_date") %>' />
                       <br />
                      
                      
                       <br />
                       
                   </ItemTemplate>
                   <SelectedItemStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
               </asp:DataList>
               <asp:SqlDataSource ID="FriendDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" SelectCommand="SELECT FriendRequests.ID, FriendRequests.Request_from, FriendRequests.Request_to, FriendRequests.Request_status, FriendRequests.Request_date, UserProfiles.ProfilePicture, UserProfiles.FullName FROM FriendRequests INNER JOIN UserProfiles ON FriendRequests.Request_from = UserProfiles.UserId WHERE (FriendRequests.Request_to = @Request_to and FriendRequests.Request_status=0) ORDER BY FriendRequests.Request_date DESC" OnSelecting="FriendDataSource1_Selecting">
                   <SelectParameters>
                       <asp:Parameter Name="Request_to" Type="Object" />
                   </SelectParameters>
               </asp:SqlDataSource>
           </asp:Panel>
                    
               </ContentTemplate>
              <%-- <Triggers>
                   <asp:AsyncPostBackTrigger ControlID="ButtonReqAccept" />
               </Triggers>--%>
               
           </asp:UpdatePanel>
</asp:Content>

