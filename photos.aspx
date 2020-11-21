<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage2.master" AutoEventWireup="true" enableEventValidation="true" CodeFile="photos.aspx.cs" Inherits="Default3" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="js/jquery.js"></script>
    <script src="js/ajaxupload-min.js"></script>
<%--    <link href="css/baseTheme/style.css" rel="stylesheet" media="all" />--%>
    <link rel="stylesheet" type="text/css" href="css/master.css"/>
    <link href="css/classicTheme/style.css" rel="stylesheet" media="all" />
  
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder_top_menu" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder_left_menu" Runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
    <div class="clearfix" id="group_header"><!-- group -->
      <div class="clearfix grpelem" id="group_column"><!-- column -->
       <ul class="MenuBar shadow rounded-corners clearfix colelem" id="group_menu_bar"><!-- horizontal box -->
       
        <asp:Menu ID="MenuSub" runat="server" Orientation="Horizontal" BorderStyle="Double" CssClass="Menu">
            <Items>
                <asp:MenuItem Text="All" Value="All"></asp:MenuItem>
                <asp:MenuItem Text="Friends" Value="Friends"></asp:MenuItem>
                <asp:MenuItem Text="Family" Value="Family"></asp:MenuItem>
                <asp:MenuItem Text="Acquaintance" Value="Acquaintance"></asp:MenuItem>
                <asp:MenuItem Text="More..." Value="More..."></asp:MenuItem>
                <asp:MenuItem Text="+" Value="+"></asp:MenuItem>
            </Items>
        </asp:Menu>
        
        
        
       </ul>
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

        <div class=" clearfix grpelem" id="profile_item"><!-- group -->
            
        <asp:DetailsView ID="UserProfile" runat="server" AutoGenerateRows="False" DataKeyNames="UserId" DataSourceID="UserProfileDataSource"  Width="175px" Font-Bold="True" ForeColor="White" BorderWidth="0px">

           <EditRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />

           <Fields>

               <asp:TemplateField>

                   <ItemTemplate>
           
    <div class="image">
    
                <asp:ImageButton ID="imgchange" CssClass="hoverimage" Width="30" runat="server" Text="Change" ImageUrl="~/images/icon/white/photo146.png"  /> 
        
                       <asp:Image ID="ImageProfile" runat="server"  ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("UserId") %>' CssClass="whiteborder" />
                        
   
                        <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtenderProfilePic" runat="server" PopupControlID="PanelProfile" TargetControlID="imgchange"                                      
             DropShadow="true" BackgroundCssClass="modalBackground" CancelControlID="Button3"
             OnOkScript="onOk()" Drag="false">
        </ajaxToolkit:ModalPopupExtender>    
         </div>                  
                   </ItemTemplate>
               </asp:TemplateField>
               <asp:BoundField DataField="FullName"  SortExpression="FullName"   />
               <asp:BoundField DataField="Gender"  SortExpression="Gender" />
               <asp:BoundField DataField="Age"  SortExpression="Age"  />
               <asp:BoundField DataField="Career"  SortExpression="Career" />
              <asp:BoundField DataField="Relationship" SortExpression="Relationship" />
           </Fields>
          
           </asp:DetailsView>
            <asp:Panel ID="PanelProfile" runat="server" CssClass="popup" Style="display:none; padding:20px;" >
         
                Choose Your Profile Picture:<br />
              
          <asp:FileUpload ID="FileUploadProfile" runat="server" />
        <asp:Button ID="btnChangeProfile" runat="server" Text="Change" style="height: 20px;width: 70px;background-color: #26284f;color: white;" OnClick="btnChangeProfile_Click"  />
        <asp:Button ID="Button3" runat="server" Text="Cancel" style="height: 20px;width: 70px;background-color: #26284f;color: white;" />
                           
            
        </asp:Panel>
            </div>
      
            <asp:SqlDataSource ID="UserProfileDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" OnSelecting="UserProfileDataSource_Selecting" SelectCommand="SELECT * FROM [UserProfiles] WHERE ([UserId] = @UserId)" UpdateCommand="UPDATE [UserProfiles] SET [FullName] = @FullName, [Gender] = @Gender, [Age] = @Age, [Career] = @Career, [CareerDescription] = @CareerDescription, [ProfilePicture] = @ProfilePicture, [CoverPicture] = @CoverPicture WHERE [UserId] = @original_UserId AND (([FullName] = @original_FullName) OR ([FullName] IS NULL AND @original_FullName IS NULL)) AND (([Gender] = @original_Gender) OR ([Gender] IS NULL AND @original_Gender IS NULL)) AND (([Age] = @original_Age) OR ([Age] IS NULL AND @original_Age IS NULL)) AND (([Career] = @original_Career) OR ([Career] IS NULL AND @original_Career IS NULL)) AND (([CareerDescription] = @original_CareerDescription) OR ([CareerDescription] IS NULL AND @original_CareerDescription IS NULL)) AND (([ProfilePicture] = @original_ProfilePicture) OR ([ProfilePicture] IS NULL AND @original_ProfilePicture IS NULL)) AND (([CoverPicture] = @original_CoverPicture) OR ([CoverPicture] IS NULL AND @original_CoverPicture IS NULL))" ConflictDetection="CompareAllValues" DeleteCommand="DELETE FROM [UserProfiles] WHERE [UserId] = @original_UserId AND (([FullName] = @original_FullName) OR ([FullName] IS NULL AND @original_FullName IS NULL)) AND (([Gender] = @original_Gender) OR ([Gender] IS NULL AND @original_Gender IS NULL)) AND (([Age] = @original_Age) OR ([Age] IS NULL AND @original_Age IS NULL)) AND (([Career] = @original_Career) OR ([Career] IS NULL AND @original_Career IS NULL)) AND (([CareerDescription] = @original_CareerDescription) OR ([CareerDescription] IS NULL AND @original_CareerDescription IS NULL)) AND (([ProfilePicture] = @original_ProfilePicture) OR ([ProfilePicture] IS NULL AND @original_ProfilePicture IS NULL)) AND (([CoverPicture] = @original_CoverPicture) OR ([CoverPicture] IS NULL AND @original_CoverPicture IS NULL))" InsertCommand="INSERT INTO [UserProfiles] ([UserId], [FullName], [Gender], [Age], [Career], [CareerDescription], [ProfilePicture], [CoverPicture]) VALUES (@UserId, @FullName, @Gender, @Age, @Career, @CareerDescription, @ProfilePicture, @CoverPicture)" OldValuesParameterFormatString="original_{0}">
               <DeleteParameters>
                   <asp:Parameter Name="original_UserId" Type="Object" />
                   <asp:Parameter Name="original_FullName" Type="String" />
                   <asp:Parameter Name="original_Gender" Type="String" />
                   <asp:Parameter Name="original_Age" Type="Int32" />
                   <asp:Parameter Name="original_Career" Type="String" />
                   <asp:Parameter Name="original_CareerDescription" Type="String" />
                   <asp:Parameter Name="original_ProfilePicture" Type="Object" />
                   <asp:Parameter Name="original_CoverPicture" Type="Object" />
               </DeleteParameters>
               <InsertParameters>
                   <asp:Parameter Name="UserId" Type="Object" />
                   <asp:Parameter Name="FullName" Type="String" />
                   <asp:Parameter Name="Gender" Type="String" />
                   <asp:Parameter Name="Age" Type="Int32" />
                   <asp:Parameter Name="Career" Type="String" />
                   <asp:Parameter Name="CareerDescription" Type="String" />
                   <asp:Parameter Name="ProfilePicture" Type="Object" />
                   <asp:Parameter Name="CoverPicture" Type="Object" />
               </InsertParameters>
               <SelectParameters>
                   <asp:Parameter Name="UserId" Type="Object" />
               </SelectParameters>
               <UpdateParameters>
                   <asp:Parameter Name="FullName" Type="String" />
                   <asp:Parameter Name="Gender" Type="String" />
                   <asp:Parameter Name="Age" Type="Int32" />
                   <asp:Parameter Name="Career" Type="String" />
                   <asp:Parameter Name="CareerDescription" Type="String" />
                   <asp:Parameter Name="ProfilePicture" Type="Object" />
                   <asp:Parameter Name="CoverPicture" Type="Object" />
                   <asp:Parameter Name="original_UserId" Type="Object" />
                   <asp:Parameter Name="original_FullName" Type="String" />
                   <asp:Parameter Name="original_Gender" Type="String" />
                   <asp:Parameter Name="original_Age" Type="Int32" />
                   <asp:Parameter Name="original_Career" Type="String" />
                   <asp:Parameter Name="original_CareerDescription" Type="String" />
                   <asp:Parameter Name="original_ProfilePicture" Type="Object" />
                   <asp:Parameter Name="original_CoverPicture" Type="Object" />
               </UpdateParameters>
           </asp:SqlDataSource>
            
           <div class="shadow museBGSize grpelem" id="cover_item">
          <asp:DetailsView ID="UserCover" runat="server" AutoGenerateRows="False" DataKeyNames="UserId" DataSourceID="UserProfileDataSource" Width="400px" BorderWidth="0px">
           
           <Fields>
               <asp:TemplateField>
                   <ItemTemplate>
                       <div class="image2">
                       <asp:ImageButton ID="btnChangeCoverPic" runat="server" Text="Change" CssClass="hoverimage2" Width="30px" ImageUrl="~/images/icon/white/photo146.png" /> 
                       <asp:Image ID="ImageCover" runat="server" CssClass="covermagrin" style="height:236px;width: 415px;margin-left: -4px;border-top-right-radius: 5px;border-bottom-right-radius: 5px;" ImageUrl='<%# "CoverHandler.ashx?userid=" + Eval("UserId") %>'/>
                    </div>
                            <ajaxToolkit:ModalPopupExtender CancelControlID="Button2" ID="ModalPopupExtenderCoverPic" runat="server" PopupControlID="pnChangeCover" TargetControlID="btnChangeCoverPic" DropShadow="true" BackgroundCssClass="modalBackground" Drag="false" />

                        
                   </ItemTemplate>
               </asp:TemplateField>
               
           </Fields>
           
           </asp:DetailsView>
                <asp:Panel ID="pnChangeCover" runat="server" CssClass="popup" Style="display:none; padding:20px;">
         
                Choose Your Cover Picture:<br />
              
          <asp:FileUpload ID="FileUpload2" runat="server" />
        <asp:Button ID="btnChangeCover" runat="server" Text="Change" OnClick="btnChangeCover_Click" style="height: 20px;width: 70px;background-color: #26284f;color: white;"  />
        <asp:Button ID="Button2" runat="server" Text="Cancel"  style="height: 20px;width: 70px;background-color: #26284f;color: white;" />
                           
            
        </asp:Panel>
               
             
                   </div>
         
        
         <%--  </div>
            </div>--%>
         
      <div class="clearfix colelem" id="divider_post"><!-- group -->
       <div class="clearfix grpelem" id="photo_section"><!-- full post section -->
       <%--<div class="clearfix grpelem" id="u600"><!-- group -->--%>
      <%--  <div class="clearfix grpelem" id="pu603"><!-- post divider -->--%>
        
           <asp:Button ID="btnNewAlbum" runat="server" Text="Create Album" OnClick="btnNewAlbum_Click" style="height: 20px;width: 100px;background-color: #26284f;color: white;" />
           <asp:Panel ID="pnNewAlbum" runat="server" CssClass="popup" Style="display:none;" ScrollBars="Auto">
                <asp:Label ID="lblAlbum" runat="server" Text="Album Title:"></asp:Label>   <asp:TextBox ID="txtAlbumName" runat="server"></asp:TextBox>
               <asp:Label ID="lblLocation" runat="server" Text="Location:"></asp:Label>   <asp:TextBox ID="txtLocation" runat="server"></asp:TextBox>
               <asp:Button ID="btnNewAlbumCancel" runat="server" Text="Cancel" OnClick="btnNewAlbumCancel_Click" style="height: 20px;width: 70px;background-color: #26284f;color: white;" />
               <div class="demo" runat="server" > </div>
               <asp:HiddenField ID="uploaded_files" runat="server" />
                 <script>
                     $('.demo').ajaxupload({
                         url: 'upload.aspx',
                         autoStart: true,
                         finish: function(d){
                             //alert(d);
                             $("#<%=uploaded_files.ClientID %>").val(d);
                            
                         }
                     });
                    
                 
                     //var file_list = AU.files;//get all the files object
                    
                     //var file = file_list[0]; //a single fileObject
                     ////alert(file);
    </script>
         <div style="text-align:right;padding:10px">
              
               
              <br />
<%--          <ajaxToolkit:AjaxFileUpload Visible="true" ID="AjaxFileUpload1" runat="server" OnUploadCompleteAll="AjaxFileUpload1_UploadCompleteAll" MaximumNumberOfFiles="10" AllowedFileTypes="jpg,jpeg,tiff,png,gif"/>--%>
      
           
               
             <asp:Button ID="btnAlbumCreate" runat="server" Text="Upload" OnClick="btnAlbumCreate_Click" style="height: 20px;width: 70px;background-color: #26284f;color: white;" />
      
        </div>
        </asp:Panel>
           <ajaxToolkit:RoundedCornersExtender ID="rce" runat="server"
    TargetControlID="pnNewAlbum"
    Radius="6"
    Corners="All" />
        <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender2" runat="server" PopupControlID="pnNewAlbum" TargetControlID="btnNewAlbum"                                      
             DropShadow="true" BackgroundCssClass="modalBackground"
             OnOkScript="onOk()" Drag="false">
        </ajaxToolkit:ModalPopupExtender>
           <asp:Button ID="fake" runat="server" Text="Button" Visible="false" />
            <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtenderGallery" runat="server" PopupControlID="pnShowPhotos" TargetControlID="fake"                                      
             DropShadow="true" BackgroundCssClass="modalBackground"
             OnOkScript="onOk()" Drag="false">
        </ajaxToolkit:ModalPopupExtender>
           <asp:Panel ID="pnShowPhotos" runat="server" CssClass="popup" style="
    display: none;
">
                  <asp:Image ID="Image1" runat="server" Width="500" Height="500" />
               <asp:Button ID="Button4" runat="server" Text="Add Description" />
               <div class="colelem like_dislike_share_section">
                       <asp:ImageButton ID="LinkButtonLike" runat="server" CommandName="LikeButton" Width="20" ImageUrl="~/images/icon/gray/thumbs_like.png" ></asp:ImageButton>
                      <%-- <asp:LinkButton ID="LinkButtonDislike" runat="server">Dislike</asp:LinkButton>
                       <asp:LinkButton ID="LinkButtonComment" runat="server">Comment</asp:LinkButton>--%>
<%--                          <asp:HyperLink ID="LikeCountLabel" runat="server" NavigateUrl='<%# Eval("LikeId","~/liked_post.aspx?likeid={0}") %>' />--%>
                       <asp:ImageButton ID="ImageButtonShare" runat="server" CommandName="SharePostId" Width="20" ImageUrl="~/images/icon/black/share3.png" ></asp:ImageButton>

              <%--         <asp:Label ID="LikeIdLabel" runat="server" Text='<%# Eval("LikeId") %>' Visible="false" />--%>
                            
                           
                           <asp:Button ID="LinkViewAllComment" runat="server" Visible="true" Text="View all comments" CommandName="allcomment"></asp:Button>
                       
                          
                           </div>
               <asp:Button ID="Button1" runat="server" Text="Next" OnClick="Button1_Click1" />
           </asp:Panel>
        
            <asp:ListView ID="ListView1" runat="server" DataSourceID="PhotoAlbumsDS" DataKeyNames="ID" GroupItemCount="3" OnItemCommand="ListView1_ItemCommand">
                
                <EditItemTemplate>
                    <td runat="server" style="">ID:
                        <asp:Label ID="IDLabel1" runat="server" Text='<%# Eval("ID") %>' />
                        <br />Name:
                        <asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' />
                        <br />UserId:
                        <asp:TextBox ID="UserIdTextBox" runat="server" Text='<%# Bind("UserId") %>' />
                        <br />DateCreated:
                        <asp:TextBox ID="DateCreatedTextBox" runat="server" Text='<%# Bind("DateCreated") %>' />
                        <br />
                        <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                        <br />
                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" style="height: 20px;width: 70px;background-color: #26284f;color: white;" />
                        <br /></td>
                </EditItemTemplate>
                <EmptyDataTemplate>
                    <table runat="server" style="">
                        <tr>
                            <td>No data was returned.</td>
                        </tr>
                    </table>
                </EmptyDataTemplate>
                <EmptyItemTemplate>
<td runat="server" />
                </EmptyItemTemplate>
                <GroupTemplate>
                    <tr id="itemPlaceholderContainer" runat="server" style="margin-right:55px;">
                        <td id="itemPlaceholder" runat="server" style="margin-right:55px;"></td>
                    </tr>
                </GroupTemplate>
                <InsertItemTemplate>
                    <td runat="server" style="">ID:
                        <asp:TextBox ID="IDTextBox" runat="server" Text='<%# Bind("ID") %>' />
                        <br />Name:
                        <asp:TextBox ID="NameTextBox" runat="server" Text='<%# Bind("Name") %>' />
                        <br />UserId:
                        <asp:TextBox ID="UserIdTextBox" runat="server" Text='<%# Bind("UserId") %>' />
                        <br />DateCreated:
                        <asp:TextBox ID="DateCreatedTextBox" runat="server" Text='<%# Bind("DateCreated") %>' />
                        <br />
                        <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" />
                        <br />
                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />
                        <br /></td>
                </InsertItemTemplate>
                <ItemTemplate>
                    <td runat="server" style="background-color:white; border-radius:5px;text-align: center;font-weight: bold;border: 2px solid black;" >
                        <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' Visible="false" />
                         <asp:Label ID="UserIdLabel" runat="server" Text='<%# Eval("UserId") %>' Visible="false" />
                        
                     <%--   <button runat="server" onserverclick="NameLabel_Click" style="margin:10px;cursor:pointer">--%>
                          
                        <br />Album:
                        <asp:Button ID="NameLabel" runat="server" style="
    color: white;
    background-color: #222b50;
    height: 40px;
    width: 130px;
    text-align: center;
    border-radius:10px;
" Text='<%# Eval("Name") %>' CommandName="showalbum" CommandArgument='<%# Eval("ID") %>' />
                                             
                        <br />DateCreated:
                        <asp:Label ID="DateCreatedLabel" runat="server" Text='<%# Eval("DateCreated") %>' />
                        <br />
                      <%--      </button>--%>

                    </td>
                </ItemTemplate>
                <LayoutTemplate>
                    <table runat="server">
                        <tr runat="server">
                            <td runat="server">
                                <table id="groupPlaceholderContainer" runat="server" style="margin-right:35px;margin-top: 10px;" >
                                    <tr id="groupPlaceholder" runat="server" >
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr runat="server">
                            <td runat="server" style=""></td>
                        </tr>
                    </table>
                </LayoutTemplate>
                <SelectedItemTemplate>
                    <td runat="server" style="">ID:
                        <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' />
                        <br />Name:
                        <asp:Label ID="NameLabel" runat="server" Text='<%# Eval("Name") %>' />
                        <br />UserId:
                        <asp:Label ID="UserIdLabel" runat="server" Text='<%# Eval("UserId") %>' />
                        <br />DateCreated:
                        <asp:Label ID="DateCreatedLabel" runat="server" Text='<%# Eval("DateCreated") %>' />
                        <br /></td>
                </SelectedItemTemplate>
            </asp:ListView>
     
       
            <asp:SqlDataSource ID="PhotoAlbumsDS" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" OnSelecting="PhotoAlbumsDS_Selecting" SelectCommand="SELECT * FROM [PhotoAlbums] WHERE ([UserId] = @UserId) ORDER BY [DateCreated]">
                <SelectParameters>
                    <asp:Parameter Name="UserId" Type="Object" />
                </SelectParameters>
            </asp:SqlDataSource>

        

           <asp:SqlDataSource ID="PhotoStoreDS" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" OnSelecting="PhotoStoreDS_Selecting" SelectCommand="SELECT PhotoStore.*, PhotoAlbums.* FROM PhotoStore INNER JOIN PhotoAlbums ON PhotoStore.ID = PhotoAlbums.ID WHERE (PhotoStore.ID = @ID)">
               <SelectParameters>
                   <asp:Parameter Name="ID" Type="Object" />
               </SelectParameters>
           </asp:SqlDataSource>
            <asp:SqlDataSource ID="MediaDS" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" SelectCommand="SELECT * FROM [PhotoComments] WHERE ([PhotoID] = @PhotoID) ORDER BY [CommentDate]" OnSelecting="MediaDS_Selecting">
                 <SelectParameters>
                     <asp:Parameter Name="PhotoID" Type="Object" />
                     
                 </SelectParameters>
             </asp:SqlDataSource>
           
      </div>
    <%-- </div>--%>

       <div class="clearfix grpelem" id="side_menu_bar" style="margin-left: 600px;display: block;top: 330px;position: fixed;"><!-- column -->
       <asp:Button ID="btnPost" runat="server" Text="Post" CssClass="sidecatmenu"  />
          <asp:Button ID="btnVideo" runat="server" Text="Video" CssClass="sidecatmenu" OnClick="btnVideo_Click"  />
          <asp:Button ID="btnPhoto" runat="server" Text="Photo" CssClass="sidecatmenu" OnClick="btnPhoto_Click"  />
          <asp:Button ID="btnFriend" runat="server" Text="Friend" CssClass="sidecatmenu" OnClick="btnFriend_Click" />
          <asp:Button ID="btnAbout" runat="server" Text="About" CssClass="sidecatmenu" OnClick="btnAbout_Click"  />
          
       </div>

       

    </div>
   
   </div>
  </div>
</asp:Content>

