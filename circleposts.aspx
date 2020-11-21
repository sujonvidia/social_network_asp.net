<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage2.master" AutoEventWireup="true" CodeFile="circleposts.aspx.cs" Inherits="Default3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <link rel="stylesheet" type="text/css" href="css/profile-list.css?262875427" id="pagesheet3"/>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder_top_menu" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder_left_menu" Runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
    <div class="clearfix" id="group_header"><!-- group -->

            <%--<div>
 <asp:UpdatePanel ID="UpdatePanel3" runat="server"
 UpdateMode="Always">
 <ContentTemplate>--%>

        
         <ajaxToolkit:ModalPopupExtender ID="MPECircleMore" runat="server" PopupControlID="pnCircleMore" TargetControlID="btnFAKE2"                                      
             DropShadow="true"  CancelControlID="btnCircleMoreCancel" Drag="false" RepositionMode="None" X="870" Y="70">
        </ajaxToolkit:ModalPopupExtender>
           <asp:Panel ID="pnCircleMore" runat="server" CssClass="popup" Style="display:none;" >
               <asp:ListView ID="lstCircleMore" runat="server" DataSourceID="circlemoreDS" OnItemCommand="lstCircleMore_ItemCommand">
                   
                   <EditItemTemplate>
                       <span style="">ID:
                       <asp:TextBox ID="IDTextBox" runat="server" Text='<%# Bind("ID") %>' />
                       <br />
                       Name:
                       <asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' />
                       <br />
                       UserId:
                       <asp:TextBox ID="UserIdTextBox" runat="server" Text='<%# Bind("UserId") %>' />
                       <br />
                       <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                       <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                       <br />
                       <br />
                       </span>
                   </EditItemTemplate>
                   <EmptyDataTemplate>
                       <span>No more circles found.</span>
                   </EmptyDataTemplate>
                   <InsertItemTemplate>
                       <span style="">ID:
                       <asp:TextBox ID="IDTextBox" runat="server" Text='<%# Bind("ID") %>' />
                       <br />
                       Name:
                       <asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' />
                       <br />
                       UserId:
                       <asp:TextBox ID="UserIdTextBox" runat="server" Text='<%# Bind("UserId") %>' />
                       <br />
                       <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" />
                       <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />
                       <br />
                       <br />
                       </span>
                   </InsertItemTemplate>
                   <ItemTemplate>
                       <span style="">
                       
                       <asp:Button ID="ButtonLabel" runat="server" Text='<%# Eval("Name") %>' CommandName="morecircle" />
                       
                       <br />
                       </span>
                   </ItemTemplate>
                   <LayoutTemplate>
                       <div id="itemPlaceholderContainer" runat="server" style="">
                           <span runat="server" id="itemPlaceholder" />
                       </div>
                       <div style="">
                       </div>
                   </LayoutTemplate>
                   <SelectedItemTemplate>
                       <span style="">ID:
                       <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' />
                       <br />
                       Name:
                       <asp:Label ID="NameLabel" runat="server" Text='<%# Eval("Name") %>' />
                       <br />
                       UserId:
                       <asp:Label ID="UserIdLabel" runat="server" Text='<%# Eval("UserId") %>' />
                       <br />
                       <br />
                       </span>
                   </SelectedItemTemplate>
               </asp:ListView>
               <asp:SqlDataSource ID="circlemoreDS" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" OnSelecting="circlemoreDS_Selecting" SelectCommand="SELECT * FROM [UserCircles] WHERE ([UserId] = @UserId)">
                   <SelectParameters>
                       <asp:Parameter Name="UserId" Type="Object" />
                   </SelectParameters>
               </asp:SqlDataSource>
               <asp:Button ID="btnCircleMoreCancel" runat="server" Text="Close" />
           </asp:Panel>
         <ajaxToolkit:ModalPopupExtender ID="MPECircleFriends" runat="server" PopupControlID="pnCircleFriends" TargetControlID="btnFAKE2"                                      
             DropShadow="true"  CancelControlID="btnCircleFriendsClose" Drag="false" RepositionMode="None" X="370" Y="70">
        </ajaxToolkit:ModalPopupExtender>
           <asp:Panel ID="pnCircleFriends" runat="server" CssClass="popup" Style="display:none;" >
               <asp:ListView ID="lstCircleFriends" runat="server" DataSourceID="CircleFriendsDS">
                   
                   <EditItemTemplate>
                       <span style="">FullName:
                       <asp:TextBox ID="FullNameTextBox" runat="server" Text='<%# Bind("FullName") %>' />
                       <br />
                       ProfilePicture:
                       <asp:TextBox ID="ProfilePictureTextBox" runat="server" Text='<%# Bind("ProfilePicture") %>' />
                       <br />
                       my_id:
                       <asp:TextBox ID="my_idTextBox" runat="server" Text='<%# Bind("my_id") %>' />
                       <br />
                       friend_id:
                       <asp:TextBox ID="friend_idTextBox" runat="server" Text='<%# Bind("friend_id") %>' />
                       <br />
                       <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                       <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                       <br />
                       <br />
                       </span>
                   </EditItemTemplate>
                   <EmptyDataTemplate>
                       <span>No friends found.</span>
                   </EmptyDataTemplate>
                   <InsertItemTemplate>
                       <span style="">FullName:
                       <asp:TextBox ID="FullNameTextBox" runat="server" Text='<%# Bind("FullName") %>' />
                       <br />
                       ProfilePicture:
                       <asp:TextBox ID="ProfilePictureTextBox" runat="server" Text='<%# Bind("ProfilePicture") %>' />
                       <br />
                       my_id:
                       <asp:TextBox ID="my_idTextBox" runat="server" Text='<%# Bind("my_id") %>' />
                       <br />
                       friend_id:
                       <asp:TextBox ID="friend_idTextBox" runat="server" Text='<%# Bind("friend_id") %>' />
                       <br />
                       <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" />
                       <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />
                       <br />
                       <br />
                       </span>
                   </InsertItemTemplate>
                   <ItemTemplate>
                       <span style="">
                       
                     
                           <asp:Image ID="imgfrd" runat="server"  ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("friend_id") %>' CssClass="whiteborder" Width="30" Height="30" />
                          <div style="margin-top:-40px;margin-left:50px">
                           <asp:Label ID="FullNameLabel" runat="server" Text='<%# Eval("FullName") %>' />
                              </div>
                       <br />
                       <br />
                       </span>
                   </ItemTemplate>
                   <LayoutTemplate>
                       <div id="itemPlaceholderContainer" runat="server" style="">
                           <span runat="server" id="itemPlaceholder" />
                       </div>
                       <div style="">
                       </div>
                   </LayoutTemplate>
                   <SelectedItemTemplate>
                       <span style="">FullName:
                       <asp:Label ID="FullNameLabel" runat="server" Text='<%# Eval("FullName") %>' />
                       <br />
                       ProfilePicture:
                       <asp:Label ID="ProfilePictureLabel" runat="server" Text='<%# Eval("ProfilePicture") %>' />
                       <br />
                       my_id:
                       <asp:Label ID="my_idLabel" runat="server" Text='<%# Eval("my_id") %>' />
                       <br />
                       friend_id:
                       <asp:Label ID="friend_idLabel" runat="server" Text='<%# Eval("friend_id") %>' />
                       <br />
                       <br />
                       </span>
                   </SelectedItemTemplate>
               </asp:ListView>
               <asp:Button ID="btnCircleFriendsClose" runat="server" Text="Close" />
               <asp:SqlDataSource ID="CircleFriendsDS" runat="server" OnSelecting="CircleFriendsDS_Selecting" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" SelectCommand="SELECT UserProfiles.FullName, UserProfiles.ProfilePicture, FriendsList.my_id, FriendsList.friend_id FROM FriendsList INNER JOIN UserProfiles ON FriendsList.friend_id = UserProfiles.UserId WHERE (FriendsList.my_id = @my_id)">
                   <SelectParameters>
                       <asp:Parameter Name="my_id" />
                   </SelectParameters>
               </asp:SqlDataSource>
               </asp:Panel>
         <ajaxToolkit:ModalPopupExtender ID="MPECircleFamily" runat="server" PopupControlID="pnCircleFamily" TargetControlID="btnFAKE2"                                      
             DropShadow="true"  CancelControlID="btnCircleFamilyClose" Drag="false" RepositionMode="None" X="520" Y="70">
        </ajaxToolkit:ModalPopupExtender>
           <asp:Panel ID="pnCircleFamily" runat="server" CssClass="popup" Style="display:none;" >
               <asp:ListView ID="lstCircleFamily" runat="server" DataSourceID="CircleFamilyDS">
                   
                   <EditItemTemplate>
                       <span style="">UserId:
                       <asp:TextBox ID="UserIdTextBox" runat="server" Text='<%# Bind("UserId") %>' />
                       <br />
                       CircleName:
                       <asp:TextBox ID="CircleNameTextBox" runat="server" Text='<%# Bind("CircleName") %>' />
                       <br />
                       FullName:
                       <asp:TextBox ID="FullNameTextBox" runat="server" Text='<%# Bind("FullName") %>' />
                       <br />
                       ProfilePicture:
                       <asp:TextBox ID="ProfilePictureTextBox" runat="server" Text='<%# Bind("ProfilePicture") %>' />
                       <br />
                       MemberId:
                       <asp:TextBox ID="MemberIdTextBox" runat="server" Text='<%# Bind("MemberId") %>' />
                       <br />
                       <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                       <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                       <br />
                       <br />
                       </span>
                   </EditItemTemplate>
                   <%--<EmptyDataTemplate>
                       <span>No data was returned.</span>
                   </EmptyDataTemplate>--%>
                   <InsertItemTemplate>
                       <span style="">UserId:
                       <asp:TextBox ID="UserIdTextBox" runat="server" Text='<%# Bind("UserId") %>' />
                       <br />
                       CircleName:
                       <asp:TextBox ID="CircleNameTextBox" runat="server" Text='<%# Bind("CircleName") %>' />
                       <br />
                       FullName:
                       <asp:TextBox ID="FullNameTextBox" runat="server" Text='<%# Bind("FullName") %>' />
                       <br />
                       ProfilePicture:
                       <asp:TextBox ID="ProfilePictureTextBox" runat="server" Text='<%# Bind("ProfilePicture") %>' />
                       <br />
                       MemberId:
                       <asp:TextBox ID="MemberIdTextBox" runat="server" Text='<%# Bind("MemberId") %>' />
                       <br />
                       <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" />
                       <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />
                       <br />
                       <br />
                       </span>
                   </InsertItemTemplate>
                   <ItemTemplate>
                       <span style="">
                     
                     
                      
                           <asp:Image ID="imgfrd" runat="server"  ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("MemberId") %>' CssClass="whiteborder" Width="30" Height="30" />
                          <div style="margin-top:-40px;margin-left:50px">
                           <asp:Label ID="FullNameLabel" runat="server" Text='<%# Eval("FullName") %>' />
                              </div>
                       <br />
                     
                       </span>
                   </ItemTemplate>
                   <LayoutTemplate>
                       <div id="itemPlaceholderContainer" runat="server" style="">
                           <span runat="server" id="itemPlaceholder" />
                       </div>
                       <div style="">
                       </div>
                   </LayoutTemplate>
                   <SelectedItemTemplate>
                       <span style="">UserId:
                       <asp:Label ID="UserIdLabel" runat="server" Text='<%# Eval("UserId") %>' />
                       <br />
                       CircleName:
                       <asp:Label ID="CircleNameLabel" runat="server" Text='<%# Eval("CircleName") %>' />
                       <br />
                       FullName:
                       <asp:Label ID="FullNameLabel" runat="server" Text='<%# Eval("FullName") %>' />
                       <br />
                       ProfilePicture:
                       <asp:Label ID="ProfilePictureLabel" runat="server" Text='<%# Eval("ProfilePicture") %>' />
                       <br />
                       MemberId:
                       <asp:Label ID="MemberIdLabel" runat="server" Text='<%# Eval("MemberId") %>' />
                       <br />
                       <br />
                       </span>
                   </SelectedItemTemplate>
               </asp:ListView>
               <asp:SqlDataSource ID="CircleFamilyDS" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" OnSelecting="CircleFamilyDS_Selecting" SelectCommand="SELECT CircleMembers.UserId, CircleMembers.CircleName, UserProfiles.FullName, UserProfiles.ProfilePicture, CircleMembers.MemberId FROM CircleMembers INNER JOIN UserProfiles ON CircleMembers.MemberId = UserProfiles.UserId WHERE (CircleMembers.UserId = @UserId) AND (CircleMembers.CircleName = 'Family')">
                   <SelectParameters>
                       <asp:Parameter Name="UserId" />
                   </SelectParameters>
               </asp:SqlDataSource>
               <asp:TextBox ID="txtCircleFamilyAdd" runat="server"></asp:TextBox>
               <br />
               <asp:TextBox ID="txtCircleFamilyID" runat="server" CssClass="displaynone"></asp:TextBox>
                <ajaxToolkit:AutoCompleteExtender OnClientItemSelected="GetFriendID" ID="AutoCompleteExtender2" runat="server" MinimumPrefixLength="1" ServiceMethod="GetFriendInfo" ServicePath="WebService2.asmx" TargetControlID="txtCircleFamilyAdd"> </ajaxToolkit:AutoCompleteExtender> 
               <asp:Button ID="btnCircleFamilyAdd" runat="server" Text="Add" OnClick="btnCircleFamilyAdd_Click" />
               <asp:Button ID="btnCircleFamilyClose" runat="server" Text="Close" />
           </asp:Panel>

          <ajaxToolkit:ModalPopupExtender ID="MPEAcquaintances" runat="server" PopupControlID="pnCircleAcquaintances" TargetControlID="btnFAKE2"                                      
             DropShadow="true"  CancelControlID="btnCircleAcquaintancesClose" Drag="false" RepositionMode="None" X="670" Y="70">
        </ajaxToolkit:ModalPopupExtender>
           <asp:Panel ID="pnCircleAcquaintances" runat="server" CssClass="popup" Style="display:none;" >

               <asp:ListView ID="lstAcquaintances" runat="server" DataSourceID="AcquaintancesDS">
                   
                   <EditItemTemplate>
                       <span style="">FullName:
                       <asp:TextBox ID="FullNameTextBox" runat="server" Text='<%# Bind("FullName") %>' />
                       <br />
                       ProfilePicture:
                       <asp:TextBox ID="ProfilePictureTextBox" runat="server" Text='<%# Bind("ProfilePicture") %>' />
                       <br />
                       ID:
                       <asp:TextBox ID="IDTextBox" runat="server" Text='<%# Bind("ID") %>' />
                       <br />
                       MemberId:
                       <asp:TextBox ID="MemberIdTextBox" runat="server" Text='<%# Bind("MemberId") %>' />
                       <br />
                       CircleName:
                       <asp:TextBox ID="CircleNameTextBox" runat="server" Text='<%# Bind("CircleName") %>' />
                       <br />
                       UserId:
                       <asp:TextBox ID="UserIdTextBox" runat="server" Text='<%# Bind("UserId") %>' />
                       <br />
                       <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                       <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                       <br />
                       <br />
                       </span>
                   </EditItemTemplate>
                   <%--<EmptyDataTemplate>
                       <span>No data was returned.</span>
                   </EmptyDataTemplate>--%>
                   <InsertItemTemplate>
                       <span style="">FullName:
                       <asp:TextBox ID="FullNameTextBox" runat="server" Text='<%# Bind("FullName") %>' />
                       <br />
                       ProfilePicture:
                       <asp:TextBox ID="ProfilePictureTextBox" runat="server" Text='<%# Bind("ProfilePicture") %>' />
                       <br />
                       ID:
                       <asp:TextBox ID="IDTextBox" runat="server" Text='<%# Bind("ID") %>' />
                       <br />
                       MemberId:
                       <asp:TextBox ID="MemberIdTextBox" runat="server" Text='<%# Bind("MemberId") %>' />
                       <br />
                       CircleName:
                       <asp:TextBox ID="CircleNameTextBox" runat="server" Text='<%# Bind("CircleName") %>' />
                       <br />
                       UserId:
                       <asp:TextBox ID="UserIdTextBox" runat="server" Text='<%# Bind("UserId") %>' />
                       <br />
                       <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" />
                       <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />
                       <br />
                       <br />
                       </span>
                   </InsertItemTemplate>
                   <ItemTemplate>
                       <span style="">  
                           
                           <asp:Image ID="imgfrd" runat="server"  ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("MemberId") %>' CssClass="whiteborder" Width="30" Height="30" />
                          <div style="margin-top:-40px;margin-left:50px">
                           <asp:Label ID="FullNameLabel" runat="server" Text='<%# Eval("FullName") %>' />
                              </div>
                       <br />
                       </span>
                   </ItemTemplate>
                   <LayoutTemplate>
                       <div id="itemPlaceholderContainer" runat="server" style="">
                           <span runat="server" id="itemPlaceholder" />
                       </div>
                       <div style="">
                       </div>
                   </LayoutTemplate>
                   <SelectedItemTemplate>
                       <span style="">FullName:
                       <asp:Label ID="FullNameLabel" runat="server" Text='<%# Eval("FullName") %>' />
                       <br />
                       ProfilePicture:
                       <asp:Label ID="ProfilePictureLabel" runat="server" Text='<%# Eval("ProfilePicture") %>' />
                       <br />
                       ID:
                       <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' />
                       <br />
                       MemberId:
                       <asp:Label ID="MemberIdLabel" runat="server" Text='<%# Eval("MemberId") %>' />
                       <br />
                       CircleName:
                       <asp:Label ID="CircleNameLabel" runat="server" Text='<%# Eval("CircleName") %>' />
                       <br />
                       UserId:
                       <asp:Label ID="UserIdLabel" runat="server" Text='<%# Eval("UserId") %>' />
                       <br />
                       <br />
                       </span>
                   </SelectedItemTemplate>
               </asp:ListView>
               <asp:SqlDataSource ID="AcquaintancesDS" runat="server" OnSelecting="AcquaintancesDS_Selecting" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" SelectCommand="SELECT UserProfiles.FullName, UserProfiles.ProfilePicture, CircleMembers.ID, CircleMembers.MemberId, CircleMembers.CircleName, CircleMembers.UserId FROM CircleMembers INNER JOIN UserProfiles ON CircleMembers.MemberId = UserProfiles.UserId WHERE (CircleMembers.UserId = @UserId) AND (CircleMembers.CircleName = 'Acquaintances')">
                   <SelectParameters>
                       <asp:Parameter Name="UserId" />
                   </SelectParameters>
               </asp:SqlDataSource>
               <asp:TextBox ID="txtCircleAcquaintancesAdd" runat="server"></asp:TextBox>
               <br />
               <asp:TextBox ID="txtCircleAcquaintancesId" runat="server" CssClass="displaynone"></asp:TextBox>
                <ajaxToolkit:AutoCompleteExtender OnClientItemSelected="GetFriendID" ID="AutoCompleteExtender3" runat="server" MinimumPrefixLength="1" ServiceMethod="GetFriendInfo" ServicePath="WebService2.asmx" TargetControlID="txtCircleAcquaintancesAdd"> </ajaxToolkit:AutoCompleteExtender> 
               <asp:Button ID="btnCircleAcquaintancesAdd" runat="server" Text="Add" OnClick="btnCircleAcquaintancesAdd_Click" />
               <asp:Button ID="btnCircleAcquaintancesClose" runat="server" Text="Close" />
               </asp:Panel>

     
      <div class="clearfix grpelem" id="group_column"><!-- column -->
       <ul class="MenuBar shadow rounded-corners clearfix colelem" id="group_menu_bar"><!-- horizontal box -->
       <asp:Button ID="btnFAKE2" runat="server" Text="Fake Button" style="display: none;" />
          <ajaxToolkit:ModalPopupExtender ID="MPEAddCircle" runat="server" PopupControlID="pnAddCircle" TargetControlID="btnFAKE2"                                      
             DropShadow="true" BackgroundCssClass="modalBackground" CancelControlID="btnCircleCancel" Drag="false">
        </ajaxToolkit:ModalPopupExtender>
           <asp:Panel ID="pnAddCircle" runat="server" CssClass="popup" Style="display:none;">
               Enter Circle Name : <asp:TextBox ID="txtNewCircle" runat="server"></asp:TextBox>
               <asp:Button ID="btnCircleCreate" runat="server" Text="Create" OnClick="btnCircleCreate_Click" />
               <asp:Button ID="btnCircleCancel" runat="server" Text="Cancel" />
               </asp:Panel>


        <asp:Menu ID="MenuSub" runat="server" Orientation="Horizontal" BorderStyle="Double" CssClass="Menu" OnMenuItemClick="MenuSub_MenuItemClick">
            <Items>
                <asp:MenuItem Text="All" Value="All"></asp:MenuItem>
                <asp:MenuItem Text="Close Friends" Value="Close Friends"></asp:MenuItem>
                <asp:MenuItem Text="Family" Value="Family"></asp:MenuItem>
                <asp:MenuItem Text="Acquaintances" Value="Acquaintances"></asp:MenuItem>
                <asp:MenuItem Text="More..." Value="More..."></asp:MenuItem>
                <asp:MenuItem Text="+" Value="+"></asp:MenuItem>
            </Items>
        </asp:Menu>
        
          <%-- <ajaxToolkit:DropDownExtender runat="server" ID="DDE"
    TargetControlID="MenuSub" 
    DropDownControlID="DropPanel" />--%>
           
        
        
       </ul>
        <%--  </ContentTemplate>

 </asp:UpdatePanel>
     </div>--%>
       <ul class="MenuBar clearfix colelem" id="<%--menuu3731--%>main_menu"><!-- horizontal box -->
        <li class="MenuItemContainer clearfix grpelem" id="<%--u3787--%>main_menu_vertical"><!-- vertical box -->
         <asp:DropDownList ID="DropDownList1" Visible="false" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" BackColor="#525461" ForeColor="White">
            <asp:ListItem>All</asp:ListItem>
            <asp:ListItem>People</asp:ListItem>
            <asp:ListItem>Page</asp:ListItem>
            <asp:ListItem>Group</asp:ListItem>
        </asp:DropDownList>
         <div class="SubMenu  MenuLevel1 clearfix" id="<%--u3792--%>menu_sub_level1"><!-- vertical box -->
          <ul class="SubMenuView clearfix colelem" id="<%--u3793--%>menu_sub_view"><!-- vertical box -->
           
          </ul>
         </div>
        </li>
       </ul>
      </div>
     
     </div>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="clearfix colelem" id="divider_full"><!-- group -->
     <div class="clearfix grpelem" id="divider_profile_cover"><!-- column -->
   <%--   <div class="clearfix colelem" id="u523"><!-- group -->
       <div class="clearfix grpelem" id="u524"><!-- group -->--%>
                

        
      
            
            
           
         
        
         <%--  </div>
            </div>--%>
         <asp:Button ID="btnFAKE" runat="server" Text="Fake Button" style="display: none;" />
        
      <div class="clearfix colelem" id="divider_post"><!-- group -->
       <div class="clearfix grpelem" id="u599"><!-- full post section -->
           <asp:ListView ID="ListView1" runat="server" DataSourceID="CirclePostDS">
               
               <EditItemTemplate>
                   <span style="">PostId:
                   <asp:TextBox ID="PostIdTextBox" runat="server" Text='<%# Bind("PostId") %>' />
                   <br />
                   Post:
                   <asp:TextBox ID="PostTextBox" runat="server" Text='<%# Bind("Post") %>' />
                   <br />
                   PostDate:
                   <asp:TextBox ID="PostDateTextBox" runat="server" Text='<%# Bind("PostDate") %>' />
                   <br />
                   UserId:
                   <asp:TextBox ID="UserIdTextBox" runat="server" Text='<%# Bind("UserId") %>' />
                   <br />
                   PostContent:
                   <asp:TextBox ID="PostContentTextBox" runat="server" Text='<%# Bind("PostContent") %>' />
                   <br />
                   PostContentType:
                   <asp:TextBox ID="PostContentTypeTextBox" runat="server" Text='<%# Bind("PostContentType") %>' />
                   <br />
                   PostUser:
                   <asp:TextBox ID="PostUserTextBox" runat="server" Text='<%# Bind("PostUser") %>' />
                   <br />
                   LikeId:
                   <asp:TextBox ID="LikeIdTextBox" runat="server" Text='<%# Bind("LikeId") %>' />
                   <br />
                   DislikeId:
                   <asp:TextBox ID="DislikeIdTextBox" runat="server" Text='<%# Bind("DislikeId") %>' />
                   <br />
                   Privacy:
                   <asp:TextBox ID="PrivacyTextBox" runat="server" Text='<%# Bind("Privacy") %>' />
                   <br />
                   <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                   <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                   <br /><br /></span>
               </EditItemTemplate>
               <EmptyDataTemplate>
                   <span>No data was returned.</span>
               </EmptyDataTemplate>
               <InsertItemTemplate>
                   <span style="">PostId:
                   <asp:TextBox ID="PostIdTextBox" runat="server" Text='<%# Bind("PostId") %>' />
                   <br />Post:
                   <asp:TextBox ID="PostTextBox" runat="server" Text='<%# Bind("Post") %>' />
                   <br />PostDate:
                   <asp:TextBox ID="PostDateTextBox" runat="server" Text='<%# Bind("PostDate") %>' />
                   <br />UserId:
                   <asp:TextBox ID="UserIdTextBox" runat="server" Text='<%# Bind("UserId") %>' />
                   <br />PostContent:
                   <asp:TextBox ID="PostContentTextBox" runat="server" Text='<%# Bind("PostContent") %>' />
                   <br />PostContentType:
                   <asp:TextBox ID="PostContentTypeTextBox" runat="server" Text='<%# Bind("PostContentType") %>' />
                   <br />PostUser:
                   <asp:TextBox ID="PostUserTextBox" runat="server" Text='<%# Bind("PostUser") %>' />
                   <br />LikeId:
                   <asp:TextBox ID="LikeIdTextBox" runat="server" Text='<%# Bind("LikeId") %>' />
                   <br />DislikeId:
                   <asp:TextBox ID="DislikeIdTextBox" runat="server" Text='<%# Bind("DislikeId") %>' />
                   <br />Privacy:
                   <asp:TextBox ID="PrivacyTextBox" runat="server" Text='<%# Bind("Privacy") %>' />
                   <br />
                   <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" />
                   <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />
                   <br /><br /></span>
               </InsertItemTemplate>
               <ItemTemplate>
                   <asp:Label ID="PostIdLabel" runat="server" Text='<%# Eval("PostId") %>' Visible="false" />
                              <asp:Label ID="UserIdLabel" runat="server" Text='<%# Eval("UserId") %>' Visible="false" />
                             <asp:Label ID="PostContentTypeLabel" runat="server" Text='<%# Eval("PostContentType") %>' Visible="false" />

                            <%--   <div id="post_backcolor2" runat="server" class="colelem post_section_full"><!-- post section -->--%>
                                   <asp:Panel id="post_backcolor" runat="server" class="colelem post_section_full_list">
                    <div style="float:right;margin-right:10px;">
                           <asp:ImageButton ID="EditButton" ImageUrl="~/images/icon/gray/edit.png" Width="20" runat="server" CommandName="Edit" Text="Edit" />
                               <asp:ImageButton ID="DeleteButton" ImageUrl="~/images/icon/gray/delete.png" Width="20" runat="server" CommandName="Deletepost" Text="Delete" />
                       </div>
                       
           <%--<div class="position_content">--%>
            <div class=" colelem post_profile_photo">
             <asp:Image ID="ImagePostProfile" runat="server" Width="50" Height="50" ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("UserId") %>' />

            </div>

               <div class="post_top_info">
               
                   <asp:Label ID="PostUserLabel" runat="server" Text='<%# Eval("PostUser") %>' />
                   <br />
              
                   <asp:Label ID="PostDateLabel" runat="server" Text='<%# Eval("PostDate") %>' />
                   <br />
                         </div>
                   
            
                <div class="post_media_section">
                    <div class="displayed">
                <embed id='embed1' autostart='false' runat="server" name='mediaPlayer' type='application/x-mplayer2' pluginspage='http://microsoft.com/windows/mediaplayer/en/download/'  displaysize='4' autosize='-1' bgcolor='darkblue' showcontrols='true' showtracker='-1' showdisplay='0' showstatusbar='-1' videoborder3d='-1' width='200' height='200'  designtimesp='5311' loop='false' src='<%# "Handler.ashx?postid=" + Eval("PostId") %>' visible="false"/>
                </div>
                    </div>
               <div class="colelem post_section_list">
                   <asp:Label ID="PostLabel" runat="server" Text='<%# Eval("Post") %>' />
                   <br /></div>
               
           <%--</div>--%>
                      <div class="colelem like_dislike_share_section" style="background-color:#DEF0F4">
                       <asp:ImageButton ID="LinkButtonLike" runat="server" CommandName="LikeButton" Width="20" ImageUrl="~/images/icon/gray/thumbs_like.png" ></asp:ImageButton>
                      <%-- <asp:LinkButton ID="LinkButtonDislike" runat="server">Dislike</asp:LinkButton>
                       <asp:LinkButton ID="LinkButtonComment" runat="server">Comment</asp:LinkButton>--%>
                          <asp:HyperLink ID="LikeCountLabel" runat="server" NavigateUrl='<%# Eval("LikeId","~/liked_post.aspx?likeid={0}") %>' />
                       <asp:ImageButton ID="ImageButtonShare" runat="server" CommandName="SharePostId" Width="20" ImageUrl="~/images/icon/black/share3.png" ></asp:ImageButton>

                       <asp:Label ID="LikeIdLabel" runat="server" Text='<%# Eval("LikeId") %>' Visible="false" />
                            
                            <br />
                            <asp:LinkButton ID="LinkViewAllComment" runat="server" Visible="false">View all comments</asp:LinkButton>
                           </div>

          </asp:Panel>
               </ItemTemplate>
               <LayoutTemplate>
                   <div id="itemPlaceholderContainer" runat="server" style="">
                       <span runat="server" id="itemPlaceholder" />
                   </div>
                   <div style="">
                   </div>
               </LayoutTemplate>
               <SelectedItemTemplate>
                   <span style="">PostId:
                   <asp:Label ID="PostIdLabel" runat="server" Text='<%# Eval("PostId") %>' />
                   <br />
                   Post:
                   <asp:Label ID="PostLabel" runat="server" Text='<%# Eval("Post") %>' />
                   <br />
                   PostDate:
                   <asp:Label ID="PostDateLabel" runat="server" Text='<%# Eval("PostDate") %>' />
                   <br />
                   UserId:
                   <asp:Label ID="UserIdLabel" runat="server" Text='<%# Eval("UserId") %>' />
                   <br />
                   PostContent:
                   <asp:Label ID="PostContentLabel" runat="server" Text='<%# Eval("PostContent") %>' />
                   <br />
                   PostContentType:
                   <asp:Label ID="PostContentTypeLabel" runat="server" Text='<%# Eval("PostContentType") %>' />
                   <br />
                   PostUser:
                   <asp:Label ID="PostUserLabel" runat="server" Text='<%# Eval("PostUser") %>' />
                   <br />
                   LikeId:
                   <asp:Label ID="LikeIdLabel" runat="server" Text='<%# Eval("LikeId") %>' />
                   <br />
                   DislikeId:
                   <asp:Label ID="DislikeIdLabel" runat="server" Text='<%# Eval("DislikeId") %>' />
                   <br />
                   Privacy:
                   <asp:Label ID="PrivacyLabel" runat="server" Text='<%# Eval("Privacy") %>' />
                   <br />
<br /></span>
               </SelectedItemTemplate>
           </asp:ListView>
           <asp:SqlDataSource ID="CirclePostDS" runat="server" OnSelecting="CirclePostDS_Selecting" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" SelectCommand="SELECT b.*
FROM
(SELECT [MemberId]
FROM CircleMembers WHERE UserId=@UserId and CircleName=@CircleName
) AS a
LEFT JOIN UserPosts AS b ON
b.UserId = a.[MemberId]
ORDER BY [PostDate] DESC">
               <SelectParameters>
                   <asp:Parameter Name="UserId" />
                   <asp:Parameter Name="CircleName" />
               </SelectParameters>
           </asp:SqlDataSource>
     </div>
     <div class="clearfix grpelem" id="divider_right"><!-- column -->
       
      
         <div id="listgrid_bar" style="	width: 150px;	margin-left: 20px; margin-top:50px;	position: relative;    float:left;">
         <asp:ImageButton ID="ImageButtonGrid" runat="server" CssClass="" ImageUrl="~/images/icon/black/horizontal20.png" OnClick="ImageButtonGrid_Click" Height="40px" Width="40px"   />
             <asp:ImageButton ID="ImageButtonList" runat="server" CssClass="" ImageUrl="~/images/icon/black/six15.png" OnClick="ImageButtonList_Click" Height="40px" Width="40px"   />
             </div>
      <div class="clearfix colelem side_menu_friends"><!-- group -->
       <div class="clearfix grpelem" id="side_menu_bar"><!-- column -->
        <asp:Button ID="btnRomantic" runat="server" Text="Post" CssClass="sidecatmenu"  />
          <asp:Button ID="btnReligious" runat="server" Text="Video" CssClass="sidecatmenu"  />
          <asp:Button ID="btnPhoto" runat="server" Text="Photo" CssClass="sidecatmenu" OnClick="btnPhoto_Click"  />
          <asp:Button ID="btnFriend" runat="server" Text="Friend" CssClass="sidecatmenu" OnClick="btnFriend_Click" />
          <asp:Button ID="btnExperience" runat="server" Text="About" CssClass="sidecatmenu"  />
          
       </div>

       
      </div>
     </div>
    </div>
    <div class="pinned-colelem" id="chat_bar" runat="server" style=""><!-- simple frame -->
         <asp:PlaceHolder ID="placeHolder" runat="server" />
        

    </div>
   </div>
  </div>
</asp:Content>

