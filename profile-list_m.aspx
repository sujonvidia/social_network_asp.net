<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage2.master" AutoEventWireup="true" CodeFile="profile-list_m.aspx.cs" Inherits="Default3" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="stylesheet" type="text/css" href="css/master.css" id="pagesheet2" />
    <%--<link rel="stylesheet" type="text/css" href="css/profile-list.css?262875427" id="pagesheet2" />--%>
    <script  src="Scripts/robota.js"></script>
    <script src="Scripts/robota_answer.js"></script>
     <meta charset='utf-8'/>
		
		<style>
      .ajax__tab_body {
                width:556px!important
		    }

			textarea {
				border:2px solid #ccc;
				padding: 10px;
				vertical-align: top;
				width: 25%;
			}

			.animated {
				-webkit-transition: height 0.2s;
				-moz-transition: height 0.2s;
				transition: height 0.2s;
			}

		</style>
		<%--<script src='http://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js'></script>--%>
		<script src='jquery.autosize.js'></script>
		<script>
		    $(function () {
		        //$('.normal').autosize();
		        //$('.animated').autosize();
		        $('textarea').autosize();
		    });
		</script>
    <%--  <script src="js/jquery.js"></script>--%>
    <script src="js/ajaxupload-min.js"></script>
<%--    <link href="css/baseTheme/style.css" rel="stylesheet" media="all" />--%>

    <link href="css/classicTheme/style.css" rel="stylesheet" media="all" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <div class="clearfix" id="group_header">
        <!-- group -->
        
        <%--<div>
 <asp:UpdatePanel ID="UpdatePanel3" runat="server"
 UpdateMode="Always">
 <ContentTemplate>--%>


        <ajaxToolkit:ModalPopupExtender OnOkScript="$('html').css('overflow', 'auto');" OnCancelScript="$('html').css('overflow', 'auto');" ID="MPECircleMore" runat="server" PopupControlID="pnCircleMore" TargetControlID="btnFAKE2"
            DropShadow="true" CancelControlID="btnCircleMoreCancel" Drag="false" RepositionMode="None" X="870" Y="70">
      <Animations>
     <OnShown><Fadein Duration="0.50" /></OnShown>
            <OnHiding><Fadeout Duration="0.75" /></OnHiding>
    </Animations>
        </ajaxToolkit:ModalPopupExtender>
        <asp:Panel ID="pnCircleMore" runat="server" CssClass="popup" Style="display: none;">
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

        <div class="clearfix grpelem" id="group_column">
            <!-- column -->
            <ul class="MenuBar shadow rounded-corners clearfix colelem" id="group_menu_bar"><!-- horizontal box -->
       <asp:Button ID="btnFAKE2" runat="server" Text="Fake Button" style="display: none;" />
          <ajaxToolkit:ModalPopupExtender OnOkScript="$('html').css('overflow', 'auto');" OnCancelScript="$('html').css('overflow', 'auto');" ID="MPEAddCircle" runat="server" PopupControlID="pnAddCircle" TargetControlID="btnFAKE2"                                      
             DropShadow="true" BackgroundCssClass="modalBackground" CancelControlID="btnCircleCancel" Drag="false">
              <Animations>
     <OnShown><Fadein Duration="0.50" /></OnShown>
            <OnHiding><Fadeout Duration="0.75" /></OnHiding>
    </Animations>
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
            <ul class="MenuBar clearfix colelem" id="<%--menuu3731--%>main_menu" style="display: none;">
                <!-- horizontal box -->
                <li class="MenuItemContainer clearfix grpelem" id="<%--u3787--%>main_menu_vertical">
                    <!-- vertical box -->
                    <asp:DropDownList ID="DropDownList1" Visible="false" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" BackColor="#525461" ForeColor="White">
                        <asp:ListItem>All</asp:ListItem>
                        <asp:ListItem>People</asp:ListItem>
                        <asp:ListItem>Page</asp:ListItem>
                        <asp:ListItem>Group</asp:ListItem>
                    </asp:DropDownList>
                    <div class="SubMenu  MenuLevel1 clearfix" id="<%--u3792--%>menu_sub_level1">
                        <!-- vertical box -->
                        <ul class="SubMenuView clearfix colelem" id="<%--u3793--%>menu_sub_view">
                            <!-- vertical box -->

                        </ul>
                    </div>
                </li>
            </ul>
        </div>

    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="clearfix colelem" id="divider_full">
        <!-- group -->
        <div class="clearfix grpelem" id="divider_profile_cover">
            <!-- column -->
            <%--   <div class="clearfix colelem" id="u523"><!-- group -->
       <div class="clearfix grpelem" id="u524"><!-- group -->--%>


            <div class=" clearfix grpelem" id="profile_item">
                <!-- group -->
                <asp:DetailsView OnItemCreated="UserProfile_ItemCreated" ID="UserProfile" runat="server" AutoGenerateRows="False" DataKeyNames="UserId,PhotoID" DataSourceID="UserProfileDataSource" Width="175px" Font-Bold="True" ForeColor="White" BorderWidth="0px">
                    <EditRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
                    <Fields>
                        <asp:TemplateField>
                            <ItemTemplate>

                                <%--  <asp:Button ID="btnChangeProfilePic" runat="server" Text="Change" CssClass="btnChangeStyle" /> 
                       <asp:ImageButton ID="ImageProfile" runat="server" Width="165px" Height="160px" ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("UserId") %>' OnClick="ImageProfile_Click" />
                        <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtenderProfilePic" runat="server" PopupControlID="PanelProfile" TargetControlID="btnChangeProfilePic"                                      
             DropShadow="true" BackgroundCssClass="modalBackground"
             OnOkScript="onOk()" Drag="false">
        </ajaxToolkit:ModalPopupExtender>  --%>
                                <div class="image">

                                    <asp:ImageButton ID="imgchange" OnClientClick="$('html').css('overflow', 'hidden');" CssClass="hoverimage" Width="30" runat="server" Text="Change" ImageUrl="~/images/icon/white/photo146.png" />
                                     <%-- <a class='inline' href="#inline_content_profile" runat="server">   --%>
                                    <asp:ImageButton ID="ImageProfile" OnClientClick="$('html').css('overflow', 'hidden');" runat="server" ImageUrl='<%# "ThumbnailHandlerProfile.ashx?userid=" + Eval("UserId") %>' CssClass="whiteborder" />
                                     <%--  </a>--%>
                                          <ajaxToolkit:ModalPopupExtender OnOkScript="$('html').css('overflow', 'auto');" OnCancelScript="$('html').css('overflow', 'auto');" ID="MPEPopImage" CancelControlID="btnClose"  DropShadow="true"  Drag="false" runat="server"  TargetControlID="ImageProfile" PopupControlID="Panel1"></ajaxToolkit:ModalPopupExtender>
                      
                                <%-- <div id='inline_content_profile' style='padding:10px; background:#fff;' runat="server" >--%>
                                            <asp:Panel ID="Panel1" runat="server" style="display:none; height: 600px; opacity: 1; box-shadow: rgb(0, 0, 0) 5px 5px 5px; background-color: white;">
                                                                     <asp:Button ID="btnClose" runat="server" Text="X" style="display: block;clear: both;width: 20px;height: 20px;border-radius: 200px;margin-top: -34px;" />

                                                  <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                                        <ContentTemplate>
                                                       <div style="float:left">                   

                 <asp:Image Width="800" Height="600" ID="ImageButton2" runat="server" ImageUrl='<%# "ProfileHandler.ashx?userid=" + Eval("UserId") %>' />
                                       </div>
                                   <div style="float:right">
                                       <asp:Panel ID="Panel3" ForeColor="Black" runat="server" ScrollBars="Auto" Height="500">
                                   <asp:ListView ID="lvProfileComment" runat="server" DataKeyNames="CommentId,LikeId,CommentUser,CommentUserId" DataSourceID="MediaDS_Profile" InsertItemPosition="LastItem" OnItemInserting="lvProfileComment_ItemInserting"  OnItemCreated="ListViewPostComment2_ItemCreated" OnItemCommand="ListViewPostComment_ItemCommand">
                
                <EditItemTemplate>
                    <span style="">CommentId:
                    <asp:Label ID="CommentIdLabel1" runat="server" Text='<%# Eval("CommentId") %>' />
                    <br />
                    Comment:
                    <asp:TextBox ID="CommentTextBox" class='animated' style="width:200px"   TextMode="MultiLine" runat="server" Text='<%# Bind("Comment") %>' />
                    <br />
                    CommentUser:
                    <asp:TextBox ID="CommentUserTextBox" runat="server" Text='<%# Bind("CommentUser") %>' />
                    <br />
                    CommentDate:
                    <asp:TextBox ID="CommentDateTextBox" runat="server" Text='<%# Bind("CommentDate") %>' />
                    <br />
                    PostId:
                    <asp:TextBox ID="PostIdTextBox" runat="server" Text='<%# Bind("PostId") %>' />
                    <br />
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                    <br /><br /></span>
                </EditItemTemplate>
                <EmptyDataTemplate>
                    <span>No Comment found.</span>
                </EmptyDataTemplate>
                <InsertItemTemplate>
                    <asp:panel defaultbutton="InsertButton" runat="server">
                    <span style="">
                        <%--<div class="_u608 f3s_top" id="_u608-f3s_top"></div>--%>
                     <div class="colelem comment_new_full" >
                        <div class=" grpelem comment_new_profile_photo">
                    <asp:ImageButton ID="ImageProfile5" runat="server" Width="45px" Height="41px" />
           

                    </div>
                <div class="comment_new_section" style="">
                <asp:TextBox ID="CommentTextBox" class='animated' Rows="1"  runat="server" TextMode="MultiLine" Text='<%# Bind("Comment") %>' style="width:190px; height: 25px; margin-left: -5px;" placeholder="Write Comment..." onfocus="this.placeholder=''" onblur="this.placeholder='Write Comment...'" />
                <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Comment" style="margin-left: 210px;height: 30px;width: 70px;background-color: #26284f;color: white;margin-bottom: 5px;" />
                </div>
              
                
               <%-- <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />--%>
                </div>
                        <%--<div class="_u608 f3s_bot" id="_u608-f3s_bot"></div>--%>
                    </span>
                        </asp:panel>
                </InsertItemTemplate>
                <ItemTemplate>
                   
                    <span style="">
                    <asp:Label ID="CommentIdLabel" runat="server" Text='<%# Eval("CommentId") %>' Visible="false" />
                            <asp:Label ID="CommentUserIdLabel" runat="server" Text='<%# Eval("CommentUserId") %>' Visible="false" />


                  
                 <div class="colelem comment_post_full">
                     <div class="position_content" style="margin-top: 15px;">
           <div class=" grpelem comment_post_profile_photo" style="margin-top: -11px;">
                <asp:ImageButton ID="ImageProfile2" runat="server" style="
    display: block;
" Width="45px" Height="41px" ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("CommentUserId") %>' />

           </div>
                        
                <div class="comment_post_info">
                <asp:HyperLink ID="CommentUserLabel" runat="server" Text='<%# Eval("CommentUser") %>' NavigateUrl='<%# Eval("CommentUserName","~/index_m.aspx?un={0}") %>' /><br />
                <asp:Label ID="CommentDateLabel" runat="server" style="
    display: block;
" Text='<%# Eval("CommentDate") %>' />
                </div>
                    <%--    <div class="clearfix grpelem" id="u610-4"><!-- content -->
        <asp:Label ID="CommentLabel" runat="server" Text='<%# Eval("Comment") %>' />

       </div>--%>
                     <div class="colelem comment_post_section">
                   <asp:Literal ID="LiteralComment" runat="server" Text='<%# AddEmotes( Eval("Comment").ToString()) %>' />
                   <br /></div>
                         </div>
                     <%--<div style="margin-top:40px;">--%>
                     <div class="comment_post_like_section">
                     <%--<asp:Button ID="LinkButtonLike" runat="server" CommandName="LikeButtonComment" Text="Like" ></asp:Button>--%>
                 <asp:ImageButton ID="LinkButtonLike" CssClass="icon" runat="server" CommandArgument='<%# Eval("CommentUserId") %>' CommandName="LikeButtonComment" Width="20" ImageUrl="~/images/icon/black/thumbs_like.png" ></asp:ImageButton>

                      <%-- <asp:LinkButton ID="LinkButtonDislike" runat="server">Dislike</asp:LinkButton>--%>
                       
                       <asp:Label ID="LikeIdLabel" runat="server" Text='<%# Bind("LikeId") %>' Visible="false" />
                                                    <asp:HyperLink ID="LikeCountLabel" runat="server" NavigateUrl='<%# Eval("LikeId","~/liked_post.aspx?likeid={0}") %>' />
                         </div>
                          <%--</div>--%>
                         <hr />   
          </div>
                        
                        <%--<div class="_u608 f3s_bot" id="_u608-f3s_bot"></div>--%>
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
                    <span style="">CommentId:
                    <asp:Label ID="CommentIdLabel" runat="server" Text='<%# Eval("CommentId") %>' />
                    <br />
                    Comment:
                    <asp:Label ID="CommentLabel" runat="server" Text='<%# Eval("Comment") %>' />
                    <br />
                    CommentUser:
                    <asp:Label ID="CommentUserLabel" runat="server" Text='<%# Eval("CommentUser") %>' />
                    <br />
                    CommentDate:
                    <asp:Label ID="CommentDateLabel" runat="server" Text='<%# Eval("CommentDate") %>' />
                    <br />
                    PostId:
                    <asp:Label ID="PostIdLabel" runat="server" Text='<%# Eval("PostId") %>' />
                    <br />
<br /></span>
                </SelectedItemTemplate>
             </asp:ListView>
                                       </asp:Panel>
                            </div>
                                    </ContentTemplate>
                                    </asp:UpdatePanel>
                                                 </asp:Panel>
                                   <%--  </div>--%>
                                    <ajaxToolkit:ModalPopupExtender OnOkScript="$('html').css('overflow', 'auto');" OnCancelScript="$('html').css('overflow', 'auto');" ID="ModalPopupExtenderProfilePic" runat="server" PopupControlID="PanelProfile" TargetControlID="imgchange"
                                        DropShadow="true" BackgroundCssClass="modalBackground"
                                       Drag="false">
                                    </ajaxToolkit:ModalPopupExtender>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="FullName" SortExpression="FullName" />
                        <asp:BoundField DataField="Gender" SortExpression="Gender" />
                        <asp:BoundField DataField="Age" SortExpression="Age" />
                        <asp:BoundField DataField="Career" SortExpression="Career" />
                     <asp:BoundField DataField="Relationship" SortExpression="Relationship" />
                    </Fields>

                </asp:DetailsView>
                  <asp:SqlDataSource ID="MediaDS_Profile" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" SelectCommand="SELECT * FROM [PhotoComments] WHERE ([PhotoID] = @PhotoID) ORDER BY [CommentDate]" OnSelecting="MediaDS_Profile_Selecting">
                 <SelectParameters>
                     <asp:Parameter Name="PhotoID" Type="Object" />
                     
                 </SelectParameters>
             </asp:SqlDataSource>
                <asp:Panel ID="PanelProfile" runat="server" CssClass="popup" Style="display:none; padding:20px; border-radius:5px;">
                    Choose Your Profile Picture:<br />

                    <asp:FileUpload ID="FileUploadProfile" runat="server" />
                    <asp:Button ID="btnChangeProfile" runat="server" Text="Change" style="height: 20px;width: 70px;background-color: #26284f;color: white;" OnClick="btnChangeProfile_Click" />
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
          <asp:DetailsView ID="UserCover" OnItemCreated="UserCover_ItemCreated" runat="server" AutoGenerateRows="False" DataKeyNames="UserId,CoverID" DataSourceID="UserProfileDataSource" Width="400px" BorderWidth="0px">
           
           <Fields>
               <asp:TemplateField>
                   <ItemTemplate>
                       <div class="image2">
                       <asp:ImageButton ID="btnChangeCoverPic" OnClientClick="$('html').css('overflow', 'hidden');" runat="server" Text="Change" CssClass="hoverimage2" Width="30px" ImageUrl="~/images/icon/white/photo146.png" /> 
                       <asp:ImageButton ID="ImageCover" OnClientClick="$('html').css('overflow', 'hidden');" runat="server" CssClass="covermagrin" style="height: 235px;width: 415px;margin-left: -4px;border-top-right-radius: 5px;border-bottom-right-radius: 5px;" alt="" ImageUrl='<%# "ThumbnailHandlerCover.ashx?userid=" + Eval("UserId") %>'/>
                    </div>
                        <ajaxToolkit:ModalPopupExtender OnOkScript="$('html').css('overflow', 'auto');" OnCancelScript="$('html').css('overflow', 'auto');" ID="MPEPopImage" CancelControlID="btnClose"  DropShadow="true"  BackgroundCssClass="back" Drag="false" runat="server" TargetControlID="ImageCover" PopupControlID="Panel1"></ajaxToolkit:ModalPopupExtender>
                      
               
                               <asp:Panel ID="Panel1" runat="server" style="display:none; height: 600px; opacity: 1; box-shadow: rgb(0, 0, 0) 5px 5px 5px; background-color: white;">
                                                                     <asp:Button ID="btnClose" runat="server" Text="X" style="display: block;clear: both;width: 20px;height: 20px;border-radius: 200px;margin-top: -34px;" />

                                                  <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                                        <ContentTemplate>
                                                       <div style="float:left">                   

                 <asp:Image Width="800" Height="600" ID="ImageButtonCover" runat="server" ImageUrl='<%# "CoverHandler.ashx?userid=" + Eval("UserId") %>' />
                                       </div>
                                   <div style="float:right">
                                       <asp:Panel ID="PanelCover" ForeColor="Black" runat="server" ScrollBars="Auto" Height="500">
                                   <asp:ListView ID="lvCoverComment" runat="server" DataKeyNames="CommentId,LikeId,CommentUser,CommentUserId" DataSourceID="MediaDS_Cover" InsertItemPosition="LastItem" OnItemInserting="lvCoverComment_ItemInserting"  OnItemCreated="ListViewPostComment2_ItemCreated" OnItemCommand="ListViewPostComment_ItemCommand">
                
                <EditItemTemplate>
                    <span style="">CommentId:
                    <asp:Label ID="CommentIdLabel1" runat="server" Text='<%# Eval("CommentId") %>' />
                    <br />
                    Comment:
                    <asp:TextBox ID="CommentTextBox" class='animated' style="width:200px"   TextMode="MultiLine" runat="server" Text='<%# Bind("Comment") %>' />
                    <br />
                    CommentUser:
                    <asp:TextBox ID="CommentUserTextBox" runat="server" Text='<%# Bind("CommentUser") %>' />
                    <br />
                    CommentDate:
                    <asp:TextBox ID="CommentDateTextBox" runat="server" Text='<%# Bind("CommentDate") %>' />
                    <br />
                    PostId:
                    <asp:TextBox ID="PostIdTextBox" runat="server" Text='<%# Bind("PostId") %>' />
                    <br />
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                    <br /><br /></span>
                </EditItemTemplate>
                <EmptyDataTemplate>
                    <span>No Comment found.</span>
                </EmptyDataTemplate>
                <InsertItemTemplate>
                    <asp:panel defaultbutton="InsertButton" runat="server">
                    <span style="">
                        <%--<div class="_u608 f3s_top" id="_u608-f3s_top"></div>--%>
                     <div class="colelem comment_new_full" >
                        <div class=" grpelem comment_new_profile_photo">
                    <asp:ImageButton ID="ImageProfile5" runat="server" Width="45px" Height="41px" />
           

                    </div>
                <div class="comment_new_section" style="">
                <asp:TextBox ID="CommentTextBox" class='animated' Rows="1"  runat="server" TextMode="MultiLine" Text='<%# Bind("Comment") %>' style="width:190px; height: 25px; margin-left: -5px;" placeholder="Write Comment..." onfocus="this.placeholder=''" onblur="this.placeholder='Write Comment...'" />
                <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Comment" style="margin-left: 210px;height: 30px;width: 70px;background-color: #26284f;color: white;margin-bottom: 5px;" />
                </div>
              
                
               <%-- <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />--%>
                </div>
                        <%--<div class="_u608 f3s_bot" id="_u608-f3s_bot"></div>--%>
                    </span>
                        </asp:panel>
                </InsertItemTemplate>
                <ItemTemplate>
                   
                    <span style="">
                    <asp:Label ID="CommentIdLabel" runat="server" Text='<%# Eval("CommentId") %>' Visible="false" />
                            <asp:Label ID="CommentUserIdLabel" runat="server" Text='<%# Eval("CommentUserId") %>' Visible="false" />


                  
                 <div class="colelem comment_post_full">
                     <div class="position_content" style="margin-top: 15px;">
           <div class=" grpelem comment_post_profile_photo" style="margin-top: -11px;">
                <asp:ImageButton ID="ImageProfile2" runat="server" style="
    display: block;
" Width="45px" Height="41px" ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("CommentUserId") %>' />

           </div>
                        
                <div class="comment_post_info">
                <asp:HyperLink ID="CommentUserLabel" runat="server" Text='<%# Eval("CommentUser") %>' NavigateUrl='<%# Eval("CommentUserName","~/index_m.aspx?un={0}") %>' /><br />
                <asp:Label ID="CommentDateLabel" runat="server" style="
    display: block;
" Text='<%# Eval("CommentDate") %>' />
                </div>
                    <%--    <div class="clearfix grpelem" id="u610-4"><!-- content -->
        <asp:Label ID="CommentLabel" runat="server" Text='<%# Eval("Comment") %>' />

       </div>--%>
                     <div class="colelem comment_post_section">
                   <asp:Literal ID="LiteralComment" runat="server" Text='<%# AddEmotes( Eval("Comment").ToString()) %>' />
                   <br /></div>
                         </div>
                     <%--<div style="margin-top:40px;">--%>
                     <div class="comment_post_like_section">
                     <%--<asp:Button ID="LinkButtonLike" runat="server" CommandName="LikeButtonComment" Text="Like" ></asp:Button>--%>
                 <asp:ImageButton ID="LinkButtonLike" CssClass="icon" runat="server" CommandArgument='<%# Eval("CommentUserId") %>' CommandName="LikeButtonComment" Width="20" ImageUrl="~/images/icon/black/thumbs_like.png" ></asp:ImageButton>

                      <%-- <asp:LinkButton ID="LinkButtonDislike" runat="server">Dislike</asp:LinkButton>--%>
                       
                       <asp:Label ID="LikeIdLabel" runat="server" Text='<%# Bind("LikeId") %>' Visible="false" />
                                                    <asp:HyperLink ID="LikeCountLabel" runat="server" NavigateUrl='<%# Eval("LikeId","~/liked_post.aspx?likeid={0}") %>' />
                         </div>
                          <%--</div>--%>
                         <hr />   
          </div>
                        
                        <%--<div class="_u608 f3s_bot" id="_u608-f3s_bot"></div>--%>
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
                    <span style="">CommentId:
                    <asp:Label ID="CommentIdLabel" runat="server" Text='<%# Eval("CommentId") %>' />
                    <br />
                    Comment:
                    <asp:Label ID="CommentLabel" runat="server" Text='<%# Eval("Comment") %>' />
                    <br />
                    CommentUser:
                    <asp:Label ID="CommentUserLabel" runat="server" Text='<%# Eval("CommentUser") %>' />
                    <br />
                    CommentDate:
                    <asp:Label ID="CommentDateLabel" runat="server" Text='<%# Eval("CommentDate") %>' />
                    <br />
                    PostId:
                    <asp:Label ID="PostIdLabel" runat="server" Text='<%# Eval("PostId") %>' />
                    <br />
<br /></span>
                </SelectedItemTemplate>
             </asp:ListView>
                                       </asp:Panel>
                            </div>
                                    </ContentTemplate>
                                    </asp:UpdatePanel>
                                                 </asp:Panel>
           <ajaxToolkit:ModalPopupExtender OnOkScript="$('html').css('overflow', 'auto');" OnCancelScript="$('html').css('overflow', 'auto');" ID="ModalPopupExtenderCoverPic" runat="server" PopupControlID="pnChangeCover" 
               TargetControlID="btnChangeCoverPic" DropShadow="true" BackgroundCssClass="modalBackground" Drag="false" CancelControlID="btnCoverCancel">
                <Animations>
     <OnShown><Fadein Duration="0.50" /></OnShown>
            <OnHiding><Fadeout Duration="0.75" /></OnHiding>
    </Animations>
        </ajaxToolkit:ModalPopupExtender>  

                        
                   </ItemTemplate>
               </asp:TemplateField>
               
           </Fields>
           
           </asp:DetailsView>
                 <asp:SqlDataSource ID="MediaDS_Cover" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" SelectCommand="SELECT * FROM [PhotoComments] WHERE ([PhotoID] = @PhotoID) ORDER BY [CommentDate]" OnSelecting="MediaDS_Cover_Selecting">
                 <SelectParameters>
                     <asp:Parameter Name="PhotoID" Type="Object" />
                     
                 </SelectParameters>
             </asp:SqlDataSource>
                <asp:UpdatePanel ID="UpdatePanel2" runat="server" style="margin-left: -84px;margin-top: -20px;display: block;" UpdateMode="Conditional">
                   <Triggers>
                       <asp:AsyncPostBackTrigger ControlID="SendFriendReq" EventName="Click" />
                       <asp:AsyncPostBackTrigger ControlID="btnReq" EventName="Click" />
                   </Triggers>
                   <ContentTemplate>
                       <asp:Button ID="SendFriendReq" runat="server" Text="Add Friend" OnPreRender="SendFriendReq_PreRender" OnClick="SendFriendReq_Click" style=" background-color: #26284f;color: white;" />
               <ajaxToolkit:HoverMenuExtender ID="PopEx" runat="server"
    TargetControlID="SendFriendReq"
    PopupControlID="pnlBtnReq"
    PopupPosition="Bottom" />
               <asp:Panel ID="pnlBtnReq" runat="server" OnPreRender="pnlBtnReq_PreRender" Style="display:none;">
                   <asp:Button ID="btnReq" runat="server" Text="Unfriend" OnClick="btnReq_Click" style=" background-color: #26284f;color: white;" />
               </asp:Panel>
                   </ContentTemplate>
               </asp:UpdatePanel>
                <asp:Panel ID="pnChangeCover" runat="server" CssClass="popup" Style="display:none; padding:20px; border-radius:5px;">
         
                Choose Your Cover Picture:<br />
              
          <asp:FileUpload ID="FileUpload2" runat="server" />
        <asp:Button ID="btnChangeCover" runat="server" Text="Change" style="height: 20px;width: 70px;background-color: #26284f;color: white;" OnClick="btnChangeCover_Click"  />
        <asp:Button ID="btnCoverCancel" runat="server" Text="Cancel" style="height: 20px;width: 70px;background-color: #26284f;color: white;" />
                           
            
        </asp:Panel>
               
             <div class="arrow-up2" style="margin-left:-160px;margin-top:4px"></div>
                   </div>

            <%--  </div>
            </div>--%>
            <div class="post_new_profile_full" id="postBox" runat="server" visible="false" style="
    margin-top: 250px;
">
                <div style="margin-bottom: 10px;margin-left: 500px;">
                    <asp:ImageButton ID="ImageButtontag" runat="server" ImageUrl="~/images/icon/black/tag.png" Width="20" Height="20" style="display: none;" />
                    <asp:ImageButton ID="ImageButtonlocation" runat="server" ImageUrl="~/images/icon/black/location.png" Width="20" style="display: none;" />

                 
<%--                    <asp:FileUpload ID="FileUpload1" runat="server" Width="100px" Style="display: none" />--%>

                    <%--                 <asp:ImageButton ID="ImageButton3" runat="server" ImageUrl="~/images/icon/black/attach.png" Width="20" OnClientClick=" clk();" />--%>
                    <asp:ImageButton ID="ImageButton4" runat="server" ImageUrl="~/images/icon/black/emoticon.png" Width="20" Visible="false" />
                </div>
                <%-- <asp:TextBox ID="txt" runat="server" TextMode="MultiLine" Width="573px"></asp:TextBox>--%>
          <%--  <asp:UpdatePanel ID="UpdatePanel4" runat="server" UpdateMode="Conditional">
                 <Triggers>
                  
                   
                    
                 </Triggers>
                 <ContentTemplate>--%>
                   <ajaxToolkit:TabContainer ID="TabContainerPost" runat="server" CssClass="postboxall"  ActiveTabIndex="0" width="132"             >
                       <ajaxToolkit:TabPanel HeaderText="Text" runat="server">
                           <ContentTemplate>
                                               <asp:TextBox ID="txtNewPost" class='animated' style="width:568px;max-height: 300px; margin-top: 4px;" placeholder="Post Something..." onfocus="this.placeholder=''" onblur="this.placeholder='Post Something...'" ClientIDMode="Static" Rows="2" runat="server" TextMode="MultiLine"></asp:TextBox><br />

                                <ajaxToolkit:AutoCompleteExtender CompletionListCssClass="AutoExtender" OnClientPopulated="GetFriendImage" OnClientItemSelected="SetTag" ID="AutoCompleteExtender4" runat="server" MinimumPrefixLength="2" ServiceMethod="GetFriendTag" ServicePath="WebService.asmx" TargetControlID="txtNewPost" > </ajaxToolkit:AutoCompleteExtender> 

                                </ContentTemplate>
                       </ajaxToolkit:TabPanel>
                        <ajaxToolkit:TabPanel HeaderText="Photo" runat="server">
                           <ContentTemplate>
                                               <asp:TextBox ID="txtPhotoPost" class='animated' style="width:568px;max-height: 300px;margin-top: 4px;" placeholder="Post Something..." onfocus="this.placeholder=''" onblur="this.placeholder='Post Something...'" ClientIDMode="Static" Rows="2" runat="server" TextMode="MultiLine"></asp:TextBox><br />
            <%--   <ajaxToolkit:AsyncFileUpload ThrobberID="imgLoader" CssClass="FileUploadClass" ID="AsyncFileUpload1" runat="server" OnUploadedComplete="AsyncFileUpload1_UploadedComplete" />
<asp:Image ID="imgLoader"  CssClass="imgLoader" runat="server"
        ImageUrl = "~/images/loading2.gif" />--%>
                     
  <div class="photoupload" runat="server" > </div>
                    <asp:HiddenField ID="uploaded_files_photo" runat="server" />
               <asp:HiddenField ID="uploaded_files_type_photo" runat="server" />
                 <script>
                     var types = "";
                     //$('.photoupload').ajaxupload('option', allowExt, ['jpg', 'gif']);
                     $('.photoupload').ajaxupload({
                         url: 'upload.aspx',
                         autoStart: true,
                         maxFileSize: '2G',
                         maxFiles: 1,

                         //allowExt: [jpg,jpeg,bmp],
                         finish: function (d, obj) {

                             $("#<%=uploaded_files_photo.ClientID %>").val(d);

                             for (i = 0; i < obj.length; i++) {
                                 console.log(obj[i].file.type);
                                 types = obj[i].file.type;

                             }

                             $("#<%=uploaded_files_type_photo.ClientID %>").val(types);


                         }
                     });
                     $('.photoupload').ajaxupload('clear');


    </script>

                                </ContentTemplate>
                       </ajaxToolkit:TabPanel>
                        <ajaxToolkit:TabPanel HeaderText="Video" runat="server">
                           <ContentTemplate>
                                               <asp:TextBox ID="txtVideoPost" class='animated' style="width:568px;max-height: 300px; margin-top: 4px;" placeholder="Post Something..." onfocus="this.placeholder=''" onblur="this.placeholder='Post Something...'" ClientIDMode="Static" Rows="2" runat="server" TextMode="MultiLine"></asp:TextBox><br />
           <%--    <ajaxToolkit:AsyncFileUpload ThrobberID="imgLoader2" CssClass="FileUploadClass" ID="AsyncFileUpload2" runat="server" OnUploadedComplete="AsyncFileUpload2_UploadedComplete" />
                               <asp:Image ID="imgLoader2" CssClass="imgLoader" runat="server"
        ImageUrl = "~/images/loading2.gif" />--%>

 <div class="videoupload" runat="server" > </div>
               <asp:HiddenField ID="uploaded_files_video" runat="server" />
               <asp:HiddenField ID="uploaded_files_type_video" runat="server" />
                 <script>

                     var types = "";
                     $('.videoupload').ajaxupload({
                         url: 'upload.aspx',
                         autoStart: true,
                         maxFileSize: '2G',
                         maxFiles: 1,


                         finish: function (d, obj) {

                             $("#<%=uploaded_files_video.ClientID %>").val(d);

                             for (i = 0; i < obj.length; i++) {
                                 console.log(obj[i].file.type);
                                 types = obj[i].file.type;

                             }

                             $("#<%=uploaded_files_type_video.ClientID %>").val(types);


                         }

                     });
                     $('.videoupload').ajaxupload('clear');
                     </script>

                                </ContentTemplate>
                       </ajaxToolkit:TabPanel>
                       <ajaxToolkit:TabPanel HeaderText="link" runat="server">
                            <ContentTemplate>
                            <textarea class="one" id="linkpost" name="linkpost"  style="width: 550px; max-height: 300px; margin: 4px 0px 0px; height: 30px;resize: none;" placeholder="Your Link Here..." onfocus="this.placeholder=''" onblur="this.placeholder='Your Link Here...'" ClientIDMode="Static" Rows="2" runat="server" TextMode="MultiLine"></textarea>
                           <asp:TextBox ID="txtLinkPost" class='animated3' style="width:550px;max-height: 300px;margin-top: -4px;  resize:none" placeholder="Write Description" onfocus="this.placeholder=''" onblur="this.placeholder='Write Description'" ClientIDMode="Static" Rows="2" runat="server" TextMode="MultiLine"></asp:TextBox><br />
                   
        
        <div class="liveurl-loader"></div>
        
        <div class="liveurl">
            <div class="close" title="Entfernen"></div>
            <div class="inner">
                <div class="image"> </div>
                <div class="details">
                    <div class="info">
                        <div class="title"> </div>
                        <div class="description"> </div> 
                        <div class="url"> </div>
                    </div>

                    <div class="thumbnail">
                        <div class="pictures">
                            <div class="controls">
                                <div class="prev button inactive"></div>
                                <div class="next button inactive"></div>
                                <div class="count">
                                    <span class="current">0</span><span> von </span><span class="max">0</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="video"></div>
                </div>

            </div>
        </div>

           <%-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js" > </script>--%>
            <script src="jQuery-LiveUrl-master/jquery.liveurl.js"> </script>
            <script>

                var curImages = new Array();

                $('.one').liveUrl({
                    loadStart: function () {
                        $('.liveurl-loader').show();
                    },
                    loadEnd: function () {
                        $('.liveurl-loader').hide();
                    },
                    success: function (data) {
                        var output = $('.liveurl');
                        output.find('.title').text(data.title);
                        output.find('.description').text(data.description);
                        output.find('.url').text(data.url);
                        output.find('.image').empty();

                        output.find('.close').one('click', function () {
                            var liveUrl = $(this).parent();
                            liveUrl.hide('fast');
                            liveUrl.find('.video').html('').hide();
                            liveUrl.find('.image').html('');
                            liveUrl.find('.controls .prev').addClass('inactive');
                            liveUrl.find('.controls .next').addClass('inactive');
                            liveUrl.find('.thumbnail').hide();
                            liveUrl.find('.image').hide();

                            $('.one').trigger('clear');
                            curImages = new Array();
                        });

                        output.show('fast');

                        if (data.video != null) {
                            var ratioW = data.video.width / 350;
                            data.video.width = 350;
                            data.video.height = data.video.height / ratioW;

                            var video =
                            '<object width="' + data.video.width + '" height="' + data.video.height + '">' +
                                '<param name="movie"' +
                                      'value="' + data.video.file + '"></param>' +
                                '<param name="allowScriptAccess" value="always"></param>' +
                                '<embed src="' + data.video.file + '"' +
                                      'type="application/x-shockwave-flash"' +
                                      'allowscriptaccess="always"' +
                                      'width="' + data.video.width + '" height="' + data.video.height + '"></embed>' +
                            '</object>';
                            output.find('.video').html(video).show();


                        }
                    },
                    addImage: function (image) {
                        var output = $('.liveurl');
                        var jqImage = $(image);
                        jqImage.attr('alt', 'Preview');

                        if ((image.width / image.height) > 7
                        || (image.height / image.width) > 4) {
                            // we dont want extra large images...
                            return false;
                        }

                        curImages.push(jqImage.attr('src'));
                        output.find('.image').append(jqImage);


                        if (curImages.length == 1) {
                            // first image...

                            output.find('.thumbnail .current').text('1');
                            output.find('.thumbnail').show();
                            output.find('.image').show();
                            jqImage.addClass('active');

                        }

                        if (curImages.length == 2) {
                            output.find('.controls .next').removeClass('inactive');
                        }

                        output.find('.thumbnail .max').text(curImages.length);
                    }
                });


                $('.liveurl ').on('click', '.controls .button', function () {
                    var self = $(this);
                    var liveUrl = $(this).parents('.liveurl');
                    var content = liveUrl.find('.image');
                    var images = $('img', content);
                    var activeImage = $('img.active', content);

                    if (self.hasClass('next'))
                        var elem = activeImage.next("img");
                    else var elem = activeImage.prev("img");

                    if (elem.length > 0) {
                        activeImage.removeClass('active');
                        elem.addClass('active');
                        liveUrl.find('.thumbnail .current').text(elem.index() + 1);

                        if (elem.index() + 1 == images.length || elem.index() + 1 == 1) {
                            self.addClass('inactive');
                        }
                    }

                    if (self.hasClass('next'))
                        var other = elem.prev("img");
                    else var other = elem.next("img");

                    if (other.length > 0) {
                        if (self.hasClass('next'))
                            self.prev().removeClass('inactive');
                        else self.next().removeClass('inactive');
                    } else {
                        if (self.hasClass('next'))
                            self.prev().addClass('inactive');
                        else self.next().addClass('inactive');
                    }



                });
          </script>
               
                               
                           </ContentTemplate>                    

                       </ajaxToolkit:TabPanel>
                   </ajaxToolkit:TabContainer>
                       
             

<%--         <ajaxToolkit:AutoCompleteExtender CompletionListCssClass="AutoExtender" OnClientPopulated="GetFriendImage" OnClientItemSelected="GetFriendProfile" BehaviorID="acExt" ID="AutoCompleteExtenderPostTag" UseContextKey="true" CompletionInterval="100" EnableCaching="false" CompletionSetCount="10" runat="server" MinimumPrefixLength="1" ServiceMethod="GetFriendTag" ServicePath="WebService.asmx" TargetControlID="txtNewPost" > </ajaxToolkit:AutoCompleteExtender> --%>

         <%--    <asp:TextBox id="demo" class="tags-input" style="
    border: 1px solid #c4c4c4;
" runat="server"/>--%>
           
                <div style="margin-top: 10px">
                    <asp:ImageButton ID="ImageButton5" runat="server" ImageUrl="~/images/icon/black/privacy.png" Width="20" Height="20" />
                    <asp:DropDownList ID="ddlPrivacy" runat="server">
                        <asp:ListItem>Public</asp:ListItem>
                        <asp:ListItem>Friends</asp:ListItem>
                        <asp:ListItem>Only Me</asp:ListItem>
                    </asp:DropDownList>
               
              <%--      <asp:Image ID="Image1" Width="50" Height="50" runat="server" />--%>
                     
                </div>
                  
                <div style="float: right; margin-top: -20px; margin-bottom: 10px">

                    <asp:ImageButton ID="btnNewPost" CssClass="icon" runat="server" ImageUrl="~/images/icon/black/post.png" Width="20" OnClick="btnNewPost_Click" />
                 
                   
                    <%--   </ContentTemplate>
</asp:UpdatePanel>
                <ajaxToolkit:UpdatePanelAnimationExtender ID="UpdatePanelAnimationExtender2"
                        TargetControlID="UpdatePanel4" runat="server">
                        <Animations>
                <OnUpdating>
                    <Parallel>
                        <ScriptAction Script='onUpdatingpost();' />
                   
                    </Parallel>
                </OnUpdating>
                <OnUpdated>
                    <Parallel>
                        <ScriptAction Script='onUpdatedpost();' />
                       <FadeOut Duration="1.5" Fps="24" AnimationTarget="ContentPlaceHolder1_ListView2_items_0" />
    
                    </Parallel>
                </OnUpdated>
                        </Animations>
                    </ajaxToolkit:UpdatePanelAnimationExtender>--%>
                <div id="divImagepost" style="display: none;">
                        <div class="spinner" style="margin-left: -50px;margin-top: -49px;">
                            <div class="bounce1"></div>
                            <div class="bounce2"></div>
                            <div class="bounce3"></div>
                        </div>
                    </div>

                    <%-- <asp:Button ID="" runat="server" Text="Post" Width="50px" EnableViewState="False"  />--%>
                </div>
            </div>
            <asp:Button ID="btnFAKE" OnClientClick="$('html').css('overflow', 'hidden');" runat="server" Text="Fake Button" Style="display: none;" />
            <ajaxToolkit:ModalPopupExtender OnOkScript="$('html').css('overflow', 'auto');" OnCancelScript="$('html').css('overflow', 'auto');" ID="MPEShare" runat="server" PopupControlID="PanelShare" TargetControlID="btnFAKE"
                DropShadow="true" BackgroundCssClass="modalBackground" CancelControlID="btnCancel"
                Drag="false">
            </ajaxToolkit:ModalPopupExtender>
            <asp:Panel ID="PanelShare" runat="server" CssClass="popup" Style="display: none;">
                Share:
                <asp:DropDownList ID="ddlShareTo" runat="server">
                    <asp:ListItem>On my timeline</asp:ListItem>
                    <asp:ListItem>On a friends timeline</asp:ListItem>
                    <asp:ListItem>In a group</asp:ListItem>
                </asp:DropDownList><br />

                <asp:TextBox ID="txtFriendsName" runat="server" Visible="true"></asp:TextBox><br />
                <asp:TextBox ID="txtFriendsID" runat="server" CssClass="displaynone"></asp:TextBox>
                <ajaxToolkit:AutoCompleteExtender OnClientItemSelected="GetFriendID" ID="AutoCompleteExtender1" runat="server" MinimumPrefixLength="1" ServiceMethod="GetFriendInfo" ServicePath="WebService2.asmx" TargetControlID="txtFriendsName"></ajaxToolkit:AutoCompleteExtender>
                <asp:TextBox ID="txtShareText" OnClick="this.value=''" runat="server" Text="" TextMode="MultiLine" Rows="2" Width="300" Style="overflow: hidden" onkeyup="setHeight(this)" ToolTip="Say Something about this..."></asp:TextBox><br />

                <asp:Button ID="btnShare" runat="server" Text="Share" OnClick="btnShare_Click" />
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" />


            </asp:Panel>
            <div class="clearfix colelem" id="divider_post">
                <!-- group -->
                <div class="clearfix grpelem" id="u599">
                    <!-- full post section -->
                    <%--<div class="clearfix grpelem" id="u600"><!-- group -->--%>
                    <div class="clearfix grpelem" id="pu603"style="margin-top: 0px;">
                        <!-- post divider -->





                        <div>
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server"
                                UpdateMode="Conditional">
                                <ContentTemplate>
                                    <asp:ListView ID="ListView1" OnItemCreated="ListView1_ItemCreated" runat="server" DataKeyNames="PhotoID,LikeId,UserId,ContentType" DataSourceID="PostsDataSource1" OnItemDataBound="ListView1_ItemDataBound" OnItemCommand="ListView1_ItemCommand" EnableViewState="False">

                                        <EditItemTemplate>
                                            <span style="">
                                                <asp:Label ID="PostIdLabel" runat="server" Text='<%# Eval("PhotoID") %>' Visible="false" />
                                                <br />

                                            </span>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("PhotoID") %>' Visible="false" />
                                            <asp:Label ID="UserIdLabel" runat="server" Text='<%# Eval("UserId") %>' Visible="false" />
                                            <asp:Label ID="PostContentTypeLabel" runat="server" Text='<%# Eval("PostContentType") %>'
                                                Visible="false" />

                                            <%--   <div id="post_backcolor2" runat="server" class="colelem post_section_full"><!-- post 

section -->--%>
                                            <asp:Panel ID="post_backcolor" runat="server" class="colelem post_section_full_list">

                                                <%-- <div style="float:right;margin-right:10px;">
                           <asp:ImageButton ID="EditButton" ImageUrl="~/images/icon/gray/edit.png" Width="20" 

runat="server" CommandName="Edit" Text="Edit" />
                               <asp:ImageButton ID="DeleteButton" ImageUrl="~/images/icon/gray/delete.png" Width="20" 

runat="server" CommandName="Deletepost" Text="Delete" />
             <asp:Image ID="ImagePostProfile" runat="server" Width="50" Height="50" ImageUrl='<%# "ThumbnailHandlerPost.ashx?

userid=" + Eval("UserId") %>' />

                       </div>--%>

                                                <%--<div class="position_content">--%>
                                                <div class=" colelem post_profile_photo">
                                                    <asp:Image ID="ImagePostProfile" runat="server" Width="50" Height="50" ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("PostUserId") %>' />



                                                </div>

                                                <div class="post_top_info">
                                                    <div class="post_edit_delete">
                                                        <asp:ImageButton ID="EditButton" CssClass="icon" ImageUrl="~/images/icon/black/edit.png" Width="20"
                                                            runat="server" CommandName="Edit" Text="Edit" />
                                                        <asp:ImageButton ID="DeleteButton" CssClass="icon" ImageUrl="~/images/icon/black/delete.png" Width="20"
                                                            runat="server" CommandName="Deletepost" Text="Delete" />
     <ajaxToolkit:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" ConfirmText="Are you Sure you Want to delete ?"
                                        TargetControlID="DeleteButton">
                                    </ajaxToolkit:ConfirmButtonExtender>
  <%-- <ajaxToolkit:ModalPopupExtender TargetControlID="DeleteButton" BackgroundCssClass="modalBackground" ID="ModalPopupExtender1" runat="server" OkControlID="ok" CancelControlID="cancel" PopupControlID="PanelConfirm">
      
   </ajaxToolkit:ModalPopupExtender>--%>
                                                    </div>
                                                    <asp:HyperLink ID="PostUserLabel" runat="server" Text='<%# Eval("UserFullName") %>' NavigateUrl='<%# Eval("UserName","~/index_m.aspx?un={0}") %>' />
                                                    <br />

                                                    <asp:Label ID="PostDateLabel" runat="server" Text='<%# Eval("Date") %>' />
                                                    <br />
                                                </div>


                                                <div class="post_media_section">
                    <asp:Panel runat="server" Visible="false" ID="pnlVideo" >
                <video runat="server" id="videoplayer" style="width: 570px;"  controls="controls" src='<%# Eval("ImageUrl") %>'></video>
                       </asp:Panel>    
                                                     <a class='inline' href="#inline_content">                  
                         <asp:ImageButton ID="imgbtn" Height="300" Width="300" runat="server" ImageUrl='<%# Eval("ImageUrl") %>' Visible="false" style="
    margin-left: 185px;
" /></a>

                    </div>
                                                <div class="colelem post_section_list">
                                                    <asp:TextBox ID="PostTextBox" BorderWidth="1" BorderStyle="Solid" BorderColor="Black" runat="server"
                                                        Text='<%# Bind("Post") %>' onkeyup="setHeight(this)" Width="573" TextMode="MultiLine" />
                                                    <br />
                                                    <br />
                                                    <div style="margin-left: 10px;">
                                                        <asp:Button ID="UpdateButton" runat="server"
                                                            CommandName="Updatepost" Text="Update" />
                                                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />

                                                    </div>
                                                </div>

                                                <%--</div>--%>
                                                <div class="colelem 

like_dislike_share_section_list"
                                                    style="background-color: #DEF0F4">
                                                    <asp:ImageButton ID="LinkButtonLike" CssClass="icon" runat="server" CommandName="LikeButton" Width="20"
                                                        ImageUrl="~/images/icon/black/thumbs_like.png"></asp:ImageButton>
                                                    <%-- <asp:LinkButton ID="LinkButtonDislike" runat="server">Dislike</asp:LinkButton>
                       <asp:LinkButton ID="LinkButtonComment" runat="server">Comment</asp:LinkButton>--%>

                                                    <asp:HyperLink ID="LikeCountLabel" runat="server" NavigateUrl='<%# Eval("LikeId","~/liked_post.aspx?likeid={0}") %>' />
                                                    <asp:ImageButton Visible="false" ID="ImageButtonShare" CssClass="icon"
                                                        runat="server" CommandName="SharePostId" Width="20" ImageUrl="~/images/icon/black/share3.png"></asp:ImageButton>

                                                    <asp:Label ID="LikeIdLabel" runat="server" Text='<%# Eval("LikeId") %>' Visible="false" />

                                                    <br />
                                                    <%--  <asp:LinkButton ID="LinkViewAllComment" runat="server" Visible="false">View all comments</asp:LinkButton>--%>
                                                </div>

                                            </asp:Panel>

                                        </EditItemTemplate>
                                        <EmptyDataTemplate>
                                            <span>No data was returned.</span>
                                        </EmptyDataTemplate>
                                        <%--<InsertItemTemplate>
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
                                                <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" />
                                                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />
                                                <br />
                                                <br />
                                            </span>
                                        </InsertItemTemplate>--%>
                                        <ItemTemplate>
                                            <asp:Panel runat="server" ID="items">
                                                <asp:Label ID="PostIdLabel" runat="server" Text='<%# Eval("PhotoID") %>' Visible="false" />
                                                <asp:Label ID="UserIdLabel" runat="server" Text='<%# Eval("UserId") %>' Visible="false" />
                                                <asp:Label ID="PostContentTypeLabel" runat="server" Text='<%# Eval("ContentType") %>' Visible="false" />
                                                  <asp:Label ID="PhotoIDLabel" runat="server" Text='<%# Eval("PhotoID") %>' Visible="false" />

                                                <%--   <div id="post_backcolor2" runat="server" class="colelem post_section_full"><!-- post section -->--%>
                                                <asp:Panel ID="post_backcolor" runat="server" class="colelem post_section_full_list">

                                                    <%-- <div style="float:right;margin-right:10px;">
                           <asp:ImageButton ID="EditButton" ImageUrl="~/images/icon/gray/edit.png" Width="20" runat="server" CommandName="Edit" Text="Edit" />
                               <asp:ImageButton ID="DeleteButton" ImageUrl="~/images/icon/gray/delete.png" Width="20" runat="server" CommandName="Deletepost" Text="Delete" />
             <asp:Image ID="ImagePostProfile" runat="server" Width="50" Height="50" ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("UserId") %>' />

                       </div>--%>

                                                    <%--<div class="position_content">--%>
                                                    <div class=" colelem post_profile_photo">
                                                        <asp:Image ID="ImagePostProfile" runat="server" Width="50" Height="50" ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("PostUserId") %>' />



                                                    </div>

                                                    <div class="post_top_info">
                                                        <div class="post_edit_delete">
                                                            <asp:ImageButton ID="EditButton" CssClass="icon" ImageUrl="~/images/icon/black/edit.png" Width="20" runat="server" CommandName="Edit" Text="Edit" />
                                                            <asp:ImageButton ID="DeleteButton" CssClass="icon" ImageUrl="~/images/icon/black/delete.png" Width="20" runat="server" CommandName="Deletepost" Text="Delete" />
     <ajaxToolkit:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" ConfirmText="Are you Sure you Want to delete ?"
                                        TargetControlID="DeleteButton">
                                    </ajaxToolkit:ConfirmButtonExtender>
  <%-- <ajaxToolkit:ModalPopupExtender TargetControlID="DeleteButton" BackgroundCssClass="modalBackground" ID="ModalPopupExtender1" runat="server" OkControlID="ok" CancelControlID="cancel" PopupControlID="PanelConfirm">
      
   </ajaxToolkit:ModalPopupExtender>  --%>        
                                                             <%--<ajaxToolkit:AnimationExtender ID="AnimationExtender2" runat="server" TargetControlID="DeleteButton">
            <Animations>
       <OnClick>

        
            <Parallel AnimationTarget="items" Duration=".30" Fps="30">
                <FadeOut AnimationTarget="items" Fps="30" />
                
            </Parallel>
           
           </OnClick>
            </Animations>
        </ajaxToolkit:AnimationExtender>--%>
                                                        </div>
                                                        <asp:HyperLink ID="PostUserLabel" runat="server" Text='<%# Eval("UserFullName") %>' NavigateUrl='<%# Eval("UserName","~/index_m.aspx?un={0}") %>' />
                                                        <br />

                                                        <asp:Label ID="PostDateLabel" runat="server" Text='<%# Eval("Date") %>' />
                                                        <br />
                                                    </div>


                <div class="post_media_section">
                    <asp:Panel runat="server" Visible="false" ID="pnlVideo">
                <video runat="server" id="videoplayer" style="width: 570px;" controls="controls" src='<%# Eval("ImageUrl") %>'></video>
                       </asp:Panel>         <asp:HyperLink ID="HyperLinkViewer" runat="server">  
                     <a class='inline' href="#inline_content" runat="server" id="photo_popup">               
                         <asp:ImageButton ID="imgbtn" runat="server" ImageUrl='<%# Eval("ImageUrl") %>' Visible="false" style="
    margin-left: 185px;
" /></a></asp:HyperLink>
                    <div style='display:none'>
			<div id='inline_content' style='padding:10px; background:#fff;' runat="server" >
                           <asp:Panel ID="Panel1" ClientIDMode="Static" runat="server" style=" z-index: 10000; height: 500px; opacity: 1;  background-color: white;width: 1100px;">
                             <asp:UpdatePanel ID="UpdatePanel5" runat="server" UpdateMode="Conditional">
                     
                       <ContentTemplate>
                               <div style="float:left">
              <asp:Image Width="700" Height="500" ID="imgfull" runat="server" ImageUrl='<%# Eval("ImageUrl") %>' /><br />
<%--             <dx:ASPxBinaryImage ID="ASPxBinaryImage1" Width="700" Height="500" runat="server" Value='<%# Eval("PhotoContent")%>' ></dx:ASPxBinaryImage>--%>

                                 <asp:Button ClientIDMode="Static" ID="btnphotonext" runat="server" Text="Next" style="height: 20px;width: 70px;background-color: #26284f;color: white;" CommandName="photonext" />
                                  

                             </div>
                            <div style="float:right;margin:20px;">
<%--                                 <asp:Button ID="btnClose" runat="server" Text="X" style="margin-left: -735px;display: block;clear: both;width: 30px;height: 30px;border-radius: 300px;margin-top: -34px;border: 6px solid rgb(242, 243, 244);background: rgb(204, 222, 232);color: rgb(10, 22, 45);font-weight: bold;margin-top: -38px;" />--%>
                           <asp:ImageButton ID="Image2" runat="server" ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("UserId") %>' Style="vertical-align:top" />
<%--                                            <asp:HyperLink ID="FullNameLabel" runat="server" Text='<%# Eval("FirstName") %>' NavigateUrl='<%# Eval("UserId","~/profile-list_search.aspx?userid={0}") %>' />--%>
                                                      <asp:HyperLink ID="HyperLink2" runat="server" Text='<%# Eval("UserFullName") %>' NavigateUrl='<%# Eval("UserName","~/index_m.aspx?un={0}") %>' /> 
<br />
                       
                                <asp:Label ID="DateCreatedLabel" runat="server" style="display: block;margin-left: 56px;margin-top: -16px;" Text='<%# Eval("Date") %>' /><br />
                                <asp:Label ID="Label1" runat="server" style="margin-bottom: 20px;display: block;margin-top: 5px;" Text='<%# Eval("Description") %>' /><br />
                                  <asp:Panel ID="Panel2" Height="300" runat="server" ScrollBars="Vertical">
                               <asp:ListView ID="ListView4"  runat="server" DataKeyNames="CommentId,PhotoID,CommentUser,CommentUserId" DataSourceID="MediaDS" InsertItemPosition="LastItem" OnItemInserting="lvMediaComment_ItemInserting" OnItemCreated="ListViewPostComment_ItemCreated" OnItemCommand="ListViewPostComment_ItemCommand">
                
                <%--<EditItemTemplate>
                    <span style="">CommentId:
                    <asp:Label ID="CommentIdLabel1" runat="server" Text='<%# Eval("CommentId") %>' />
                    <br />
                    Comment:
                    <asp:TextBox ID="CommentTextBox" class='animated' style="width:200px"   TextMode="MultiLine" runat="server" Text='<%# Bind("Comment") %>' />
                    <br />
                    CommentUser:
                    <asp:TextBox ID="CommentUserTextBox" runat="server" Text='<%# Bind("CommentUser") %>' />
                    <br />
                    CommentDate:
                    <asp:TextBox ID="CommentDateTextBox" runat="server" Text='<%# Bind("CommentDate") %>' />
                    <br />
                    PostId:
                    <asp:TextBox ID="PostIdTextBox" runat="server" Text='<%# Bind("PostId") %>' />
                    <br />
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                    <br /><br /></span>
                </EditItemTemplate>--%>
                <EmptyDataTemplate>
                    <span>No Comment found.</span>
                </EmptyDataTemplate>
                <InsertItemTemplate>
                    <asp:panel defaultbutton="InsertButton" runat="server">
                    <span style="">
                        <%--<div class="_u608 f3s_top" id="_u608-f3s_top"></div>--%>
                     <div class="colelem comment_new_full" >
                        <div class=" grpelem comment_new_profile_photo">
                    <asp:ImageButton ID="ImageProfile5" runat="server" Width="45px" Height="41px" />
           
                         
                    </div>
                <div class="comment_new_section" style="">
                <asp:TextBox ID="CommentTextBox" class='animated' Rows="1"  runat="server" TextMode="MultiLine" Text='<%# Bind("Comment") %>' style="width:190px; height: 25px; margin-left: -5px;" placeholder="Write Comment..." onfocus="this.placeholder=''" onblur="this.placeholder='Write Comment...'" />
                <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Comment" style="margin-left: 210px;height: 30px;width: 70px;background-color: #26284f;color: white;margin-bottom: 5px;" />
                </div>
              
                
               <%-- <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />--%>
                </div>
                        <%--<div class="_u608 f3s_bot" id="_u608-f3s_bot"></div>--%>
                    </span>
                        </asp:panel>
                </InsertItemTemplate>
                                   
                <ItemTemplate>
                 
                  
                    <asp:Label ID="CommentIdLabel" runat="server" Text='<%# Eval("CommentId") %>' Visible="false" />
                            <asp:Label ID="CommentUserIdLabel" runat="server" Text='<%# Eval("CommentUserId") %>' Visible="false" />


                  
                 <div class="colelem comment_post_full">
                     <div class="position_content" style="margin-top: 15px;">
           <div class=" grpelem comment_post_profile_photo" style="margin-top: -11px;">
                <asp:ImageButton ID="ImageProfile2" runat="server" style="
    display: block;
" Width="45px" Height="41px" ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("CommentUserId") %>' />

           </div>
                        
                <div class="comment_post_info">
                <asp:HyperLink ID="CommentUserLabel" runat="server" Text='<%# Eval("CommentUser") %>' NavigateUrl='<%# Eval("CommentUserName","~/index_m.aspx?un={0}") %>' /><br />
                <asp:Label ID="CommentDateLabel" runat="server" style="
    display: block;
" Text='<%# Eval("CommentDate") %>' />
                </div>
                    <%--    <div class="clearfix grpelem" id="u610-4"><!-- content -->
        <asp:Label ID="CommentLabel" runat="server" Text='<%# Eval("Comment") %>' />

       </div>--%>
                     <div class="colelem comment_post_section">
                   <asp:Literal ID="LiteralComment" runat="server" Text='<%# AddEmotes( Eval("Comment").ToString()) %>' />
                   <br /></div>
                         </div>
                     <%--<div style="margin-top:40px;">--%>
                     <div class="comment_post_like_section">
                     <%--<asp:Button ID="LinkButtonLike" runat="server" CommandName="LikeButtonComment" Text="Like" ></asp:Button>--%>
                 <asp:ImageButton ID="LinkButtonLike" CssClass="icon" runat="server" CommandArgument='<%# Eval("CommentUserId") %>' CommandName="LikeButtonComment" Width="20" ImageUrl="~/images/icon/black/thumbs_like.png" ></asp:ImageButton>

                      <%-- <asp:LinkButton ID="LinkButtonDislike" runat="server">Dislike</asp:LinkButton>--%>
                       
                       <asp:Label ID="LikeIdLabel" runat="server" Text='<%# Bind("LikeId") %>' Visible="false" />
                                                    <asp:HyperLink ID="LikeCountLabel" runat="server" NavigateUrl='<%# Eval("LikeId","~/liked_post.aspx?likeid={0}") %>' />
                         </div>
                          <%--</div>--%>
                         <hr />   
          </div>
                        
                        <%--<div class="_u608 f3s_bot" id="_u608-f3s_bot"></div>--%>
                   
                      
                </ItemTemplate>
                <LayoutTemplate>
                    
                    <div id="itemPlaceholderContainer" runat="server" style="">
                        <span runat="server" id="itemPlaceholder" />
                    </div>
                    <div style="">
                    </div>
                </LayoutTemplate>
                <%--<SelectedItemTemplate>
                    <span style="">CommentId:
                    <asp:Label ID="CommentIdLabel" runat="server" Text='<%# Eval("CommentId") %>' />
                    <br />
                    Comment:
                    <asp:Label ID="CommentLabel" runat="server" Text='<%# Eval("Comment") %>' />
                    <br />
                    CommentUser:
                    <asp:Label ID="CommentUserLabel" runat="server" Text='<%# Eval("CommentUser") %>' />
                    <br />
                    CommentDate:
                    <asp:Label ID="CommentDateLabel" runat="server" Text='<%# Eval("CommentDate") %>' />
                    <br />
                    PostId:
                    <asp:Label ID="PostIdLabel" runat="server" Text='<%# Eval("PostId") %>' />
                    <br />
<br /></span>
                </SelectedItemTemplate>--%>
             </asp:ListView>
                                      <asp:SqlDataSource ID="MediaDS" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" SelectCommand="SELECT * FROM [PhotoComments] WHERE ([PhotoID] = @PhotoID) ORDER BY [CommentDate]" OnSelecting="MediaDS_Selecting">
                 <SelectParameters>
                     <asp:Parameter Name="PhotoID" Type="Object" />
                     
                 </SelectParameters>
             </asp:SqlDataSource>
                               </asp:Panel>
                            
                               </div>
                                </ContentTemplate>
                       </asp:UpdatePanel>
                       </asp:Panel>
   </div>           </div>

                    </div>
                                                    <div class="colelem post_section_list">
                                                        <asp:Literal ID="PostLabel" runat="server" Text='<%# AddEmotes(Eval("Post").ToString()) %>' /><br />
                                                         <asp:Literal ID="TitleLabel" runat="server" Text='<%# Eval("Title") %>' /><br />
                   <asp:Literal ID="Literal1" runat="server" Text='<%# AddEmotes( Eval("Description").ToString()) %>' /><br />
                       <asp:HyperLink  CssClass="one" ID="HyperLink1" NavigateUrl='<%# Eval("Link") %>' runat="server"><%# Eval("Link") %></asp:HyperLink>
                                                        <br />
                                                    </div>

                                                    <%--</div>--%>
                                                    <div class="colelem like_dislike_share_section_list" style="background-color: #DEF0F4">
                                                        <asp:ImageButton ID="LinkButtonLike" CssClass="icon" runat="server" CommandName="LikeButton" Width="20" ImageUrl="~/images/icon/black/thumbs_like.png"></asp:ImageButton>
                                                        <%-- <asp:LinkButton ID="LinkButtonDislike" runat="server">Dislike</asp:LinkButton>
                       <asp:LinkButton ID="LinkButtonComment" runat="server">Comment</asp:LinkButton>--%>
                                                        <asp:HyperLink ID="LikeCountLabel" runat="server" NavigateUrl='<%# Eval("LikeId","~/liked_post.aspx?likeid={0}") %>' />
                                                        <asp:ImageButton Visible="false" ID="ImageButtonShare" CssClass="icon" runat="server" CommandName="SharePostId" Width="20" ImageUrl="~/images/icon/black/share3.png"></asp:ImageButton>

                                                        <asp:Label ID="LikeIdLabel" runat="server" Text='<%# Eval("LikeId") %>' Visible="false" />

                                                        <br />
                                                        <asp:Button ID="LinkViewAllComment" runat="server" Visible="true" Text="View all comments" style="border-width: 1px;width: 570px;background-color: #535461;color: white; border-radius: 5px;" CommandName="allcomment"></asp:Button>
                                                        <ajaxToolkit:AnimationExtender ID="AnimationExtender1" runat="server" TargetControlID="LinkViewAllComment">
                                                            <Animations>
       <OnClick>

        
            <Parallel AnimationTarget="PanelComment" Duration="3" Fps="25">
                <FadeOut AnimationTarget="PanelComment" minimumOpacity=".1" Fps="30" />
                <FadeIn AnimationTarget="PanelComment" minimumOpacity=".1" Fps="30" />  
            </Parallel>
           
           </OnClick>
                                                            </Animations>
                                                        </ajaxToolkit:AnimationExtender>
                                                    </div>

                                                </asp:Panel>
                                                <%--<div class="_u603 f3s_bot" id="_u603-f3s_bot"></div>--%>
                                                <%--   </div>--%>
                                                <asp:Panel runat="server" ID="PanelComment">
                                                    <asp:ListView ID="ListView2" runat="server" DataKeyNames="PhotoID,LikeId,CommentUserId" DataSourceID="MediaDS" OnItemEditing="ListView2_ItemEditing" OnItemCreated="ListView2_ItemCreated" EnableViewState="false" InsertItemPosition="LastItem" OnItemInserting="lvMediaComment_ItemInserting" OnItemDataBound="ListView2_ItemDataBound" OnItemCommand="ListView2_ItemCommand">

                                                        <EditItemTemplate>
                                                            <span>Comment:
            <asp:TextBox ID="CommentTextBox" class='animated' TextMode="MultiLine" style="width:490px" runat="server" Text='<%# Bind("Comment") %>' />

                                                                <br />
                                                                <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                                                                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                                                                <br />
                                                                <br />
                                                            </span>
                                                        </EditItemTemplate>
                                                        <EmptyDataTemplate>
                                                            <span>No comment found.</span>
                                                        </EmptyDataTemplate>
                                                        <InsertItemTemplate>
                                                            <asp:Panel DefaultButton="InsertButton" runat="server">
                                                                <span style="">
                                                                    <%--<div class="_u608 f3s_top" id="_u608-f3s_top"></div>--%>
                                                                    <div class="colelem comment_new_full2" style="margin-bottom: 15px;">
                                                                        <div class=" grpelem comment_new_profile_photo">
                                                                            <asp:ImageButton ID="ImageProfile5" runat="server" Width="45px" Height="41px" OnClick="ImageProfile_Click" />


                                                                        </div>
                                                                        <div class="comment_new_section">
                                                                            <asp:TextBox ID="CommentTextBox" class='animated' placeholder="Write Comment..." onfocus="this.placeholder=''" onblur="this.placeholder='Write Comment...'" runat="server" TextMode="MultiLine" Text='<%# Bind("Comment") %>' style="width:490px;" />
                                                                            <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Comment" style="margin-left: 510px;height: 30px;width: 70px;background-color: #26284f;color: white;margin-bottom: 10px;" />
                                                                        </div>


                                                                        <%-- <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />--%>
                                                                    </div>
                                                                    <%--<div class="_u608 f3s_bot" id="_u608-f3s_bot"></div>--%>
                                                                </span>
                                                            </asp:Panel>
                                                        </InsertItemTemplate>
                                                        <ItemTemplate>
                                                            <span style="">
                                                                <asp:Label ID="CommentIdLabel" runat="server" Text='<%# Eval("CommentId") %>' Visible="false" />
                                                                <asp:Label ID="PostIdLabel" runat="server" Text='<%# Eval("PhotoID") %>' Visible="false" />


                                                                <div class="colelem comment_post_full" style="width: 593px;">
                                                                    <%--  <div class="position_content" >--%>
                                                                    <div class=" grpelem comment_post_profile_photo">
                                                                        <asp:ImageButton ID="ImageProfile2" runat="server" Width="45px" Height="41px" ImageUrl='<%# "ThumbnailHandlerPost.ashx?userid=" + Eval("CommentUserId") %>' OnClick="ImageProfile_Click" />

                                                                    </div>

                                                                    <div class="comment_post_info">
                                                                        <div class="post_edit_delete" style="margin-right: 10px;">
                                                                            <asp:ImageButton ID="EditButton" CssClass="icon" ImageUrl="~/images/icon/black/edit.png" Width="20" runat="server" CommandName="Edit" Text="Edit" />
                                                                            <asp:ImageButton ID="DeleteButton" CssClass="icon" ImageUrl="~/images/icon/black/delete.png" Width="20" runat="server" CommandName="Deletecomment" Text="Delete" />
                                                                        </div>
                                                                        <asp:HyperLink ID="CommentUserLabel" runat="server" Text='<%# Eval("CommentUser") %>' NavigateUrl='<%# Eval("CommentUserName","~/index_m.aspx?un={0}") %>' /><br />
                                                                        <asp:Label ID="CommentDateLabel" runat="server" Text='<%# Eval("CommentDate") %>' />
                                                                    </div>
                                                                    <%--    <div class="clearfix grpelem" id="u610-4"><!-- content -->
        <asp:Label ID="CommentLabel" runat="server" Text='<%# Eval("Comment") %>' />

       </div>--%>
                                                                    <div class="colelem comment_post_section">
                                                                        <asp:Literal ID="PostLabel" runat="server" Text='<%# AddEmotes( Eval("Comment").ToString()) %>' />
                                                                        <br />
                                                                    </div>
                                                                    <%--  </div>--%>
                                                                    <%--<div style="margin-top:40px;">--%>
                                                                    <div class="colelem comment_post_like_section">
                                                                        <asp:ImageButton ID="LinkButtonLike" CssClass="icon" runat="server" CommandArgument='<%# Eval("CommentUserId") %>' CommandName="LikeButtonComment" Width="20" ImageUrl="~/images/icon/black/thumbs_like.png"></asp:ImageButton>
                                                                        <%-- <asp:LinkButton ID="LinkButtonDislike" runat="server">Dislike</asp:LinkButton>--%>

                                                                        <asp:Label ID="LikeIdLabel" runat="server" Text='<%# Bind("LikeId") %>' Visible="false" />
                                                                        <asp:HyperLink ID="LikeCountLabel" runat="server" NavigateUrl='<%# Eval("LikeId","~/liked_post.aspx?likeid={0}") %>' />
                                                                    </div>
                                                                    <%--</div>--%>
                                                                    <hr style="margin-top: 80px;" />
                                                                </div>

                                                                <%--<div class="_u608 f3s_bot" id="_u608-f3s_bot"></div>--%>
                                                            </span>
                                                        </ItemTemplate>
                                                        <LayoutTemplate>
                                                            <div id="itemPlaceholderContainer" runat="server" style="font-family: Verdana, Arial, Helvetica, sans-serif;">
                                                                <span runat="server" id="itemPlaceholder" />
                                                            </div>
                                                            <div style="text-align: center; background-color: #5D7B9D; font-family: Verdana, Arial, Helvetica, sans-serif; color: #FFFFFF;">
                                                            </div>
                                                        </LayoutTemplate>
                                                        <SelectedItemTemplate>
                                                            <span style="background-color: #E2DED6; font-weight: bold; color: #333333;">Comment:
            <asp:Label ID="CommentLabel" runat="server" Text='<%# Eval("Comment") %>' />
                                                                <br />
                                                                CommentUser:
            <asp:Label ID="CommentUserLabel" runat="server" Text='<%# Eval("CommentUser") %>' />
                                                                <br />
                                                                CommentDate:
            <asp:Label ID="CommentDateLabel" runat="server" Text='<%# Eval("CommentDate") %>' />
                                                                <br />
                                                                <br />
                                                            </span>
                                                        </SelectedItemTemplate>
                                                    </asp:ListView>
                                                </asp:Panel>
                                            </asp:Panel>
                                        </ItemTemplate>
                                        <LayoutTemplate>
                                            <div id="itemPlaceholderContainer" runat="server" style="">
                                                <span runat="server" id="itemPlaceholder" />
                                            </div>
                                            <div style="">
                                            </div>
                                        </LayoutTemplate>
                                        <%--<SelectedItemTemplate>
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
                                                <br />
                                            </span>
                                            <td>
                                                <asp:Button ID="DeleteButton" runat="server" CommandName="Delete"
                                                    Text="Delete" />
                                                <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                                            </td>

                                        </SelectedItemTemplate>--%>
                                    </asp:ListView>
                                    <asp:Button ID="LoadMore" runat="server" Height="28px" Text="Load More..." Width="300" OnClick="LoadMore_Click" Style="display: none" />
                                    <div style="width: 600px; margin-left: auto; margin-right: auto; position: relative; top: 15px">
                                        <div id="divImage" style="display: none">
                                            <div class="spinner">
                                                <div class="bounce1"></div>
                                                <div class="bounce2"></div>
                                                <div class="bounce3"></div>
                                            </div>
                                        </div>
                                    </div>



                                    <asp:SqlDataSource ID="CommentsDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" SelectCommand="SELECT * FROM [UserComments] WHERE ([PostId] = @PostId) ORDER BY [CommentDate]" OnSelecting="CommentsDataSource1_Selecting" ConflictDetection="CompareAllValues" DeleteCommand="DELETE FROM [UserComments] WHERE [CommentId] = @original_CommentId AND [Comment] = @original_Comment AND (([CommentUser] = @original_CommentUser) OR ([CommentUser] IS NULL AND @original_CommentUser IS NULL)) AND [CommentDate] = @original_CommentDate AND [PostId] = @original_PostId" InsertCommand="INSERT INTO [UserComments] ([CommentId], [Comment], [CommentUser], [CommentDate], [PostId]) VALUES (@CommentId, @Comment, @CommentUser, @CommentDate, @PostId)" OldValuesParameterFormatString="original_{0}" UpdateCommand="UPDATE [UserComments] SET [Comment] = @Comment WHERE [CommentId] = @original_CommentId AND [Comment] = @original_Comment AND (([CommentUser] = @original_CommentUser) OR ([CommentUser] IS NULL AND @original_CommentUser IS NULL)) AND [CommentDate] = @original_CommentDate AND [PostId] = @original_PostId">
                                        <DeleteParameters>
                                            <asp:Parameter Name="original_CommentId" />
                                            <asp:Parameter Name="original_Comment" Type="String" />
                                            <asp:Parameter Name="original_CommentUser" Type="String" />
                                            <asp:Parameter Name="original_CommentDate" Type="DateTime" />
                                            <asp:Parameter Name="original_PostId" />
                                        </DeleteParameters>
                                        <InsertParameters>
                                            <asp:Parameter Name="CommentId" />
                                            <asp:Parameter Name="Comment" Type="String" />
                                            <asp:Parameter Name="CommentUser" Type="String" />
                                            <asp:Parameter Name="CommentDate" Type="DateTime" />
                                            <asp:Parameter Name="PostId" />
                                        </InsertParameters>
                                        <SelectParameters>
                                            <asp:Parameter Name="PostId" />
                                        </SelectParameters>
                                        <UpdateParameters>
                                            <asp:Parameter Name="Comment" Type="String" />
                                            <asp:Parameter Name="CommentUser" Type="String" />
                                            <asp:Parameter Name="CommentDate" Type="DateTime" />
                                            <asp:Parameter Name="PostId" />
                                            <asp:Parameter Name="original_CommentId" />
                                            <asp:Parameter Name="original_Comment" Type="String" />
                                            <asp:Parameter Name="original_CommentUser" Type="String" />
                                            <asp:Parameter Name="original_CommentDate" Type="DateTime" />
                                            <asp:Parameter Name="original_PostId" />
                                        </UpdateParameters>
                                    </asp:SqlDataSource>
                                    <asp:SqlDataSource ID="LikeDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" SelectCommand="SELECT * FROM [UserLikes]"></asp:SqlDataSource>


                                    </div>
                                </ContentTemplate>
                                <Triggers>

                                    <asp:AsyncPostBackTrigger ControlID="btnNewPost" EventName="Click"></asp:AsyncPostBackTrigger>
                                    <asp:AsyncPostBackTrigger ControlID="LoadMore" EventName="Click"></asp:AsyncPostBackTrigger>

                                </Triggers>
                            </asp:UpdatePanel>
                              <asp:Panel ID="PanelConfirm" runat="server" CssClass="popup"  Style="display:none;padding:20px; border-radius:5px;z-index:1000000000000 !important">
                                    <asp:Label runat="server" Text="Are you sure you want to delete this post?"></asp:Label>
       <asp:Button runat="server" Text="OK" ID="ok" />
       <asp:Button runat="server" Text="Cancel" ID="cancel" /> 
                               </asp:Panel>
                            
                        </div>
                        <asp:SqlDataSource ID="PostsDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SecurityConnectionString %>" 
                          
             SelectCommand="SELECT * FROM PhotoStore"

                            OnSelecting="PostsDataSource1_Selecting">
                          <%--  <SelectParameters>
                                <asp:Parameter Name="UserId" Type="Object" />
                                <asp:Parameter Name="TopVal" DefaultValue="4" Type="Int32" />
                            </SelectParameters>--%>
                        </asp:SqlDataSource>


                    </div>

                    <ajaxToolkit:UpdatePanelAnimationExtender ID="UpdatePanelAnimationExtender1"
                        TargetControlID="UpdatePanel1" runat="server">
                        <Animations>
                <OnUpdating>
                    <Parallel>
                        <ScriptAction Script='onUpdating();' />
                        <FadeOut Duration="30s" Fps="24" AnimationTarget="ContentPlaceHolder1_ListView1_items_0" />
                        
                    </Parallel>
                </OnUpdating>
                <OnUpdated>
                    <Parallel>
                        <ScriptAction Script='onUpdated();' />
                        <FadeOut Duration="30s" Fps="24" AnimationTarget="ContentPlaceHolder1_ListView1_items_0" />
                        <FadeIn Duration="0.1s" Fps="24"  AnimationTarget="ContentPlaceHolder1_ListView1_items_0" />
                    </Parallel>
                </OnUpdated>
                        </Animations>
                    </ajaxToolkit:UpdatePanelAnimationExtender>
                    <%--  <ajaxToolkit:UpdatePanelAnimationExtender ID="UpdatePanelAnimationExtender2"
        TargetControlID="UpdatePanel1" runat="server">
       <Animations>
                <OnUpdating>
                    <Parallel>
                        <ScriptAction Script='onUpdating();' />
                    </Parallel>
                </OnUpdating>
                <OnUpdated>
                    <Parallel>
                        <ScriptAction Script='onUpdated();' />
                    </Parallel>
                </OnUpdated>
            </Animations>
        </ajaxToolkit:UpdatePanelAnimationExtender>--%>
                    <div class="clearfix grpelem" id="divider_right" style="margin-left: 600px;margin-top: -425px;"><!-- column -->
       
      
         <div id="listgrid_bar" style="width: 135px;	margin-left: 15px; margin-top: 70px;	position: relative;    /*float:left;*/">
         <asp:ImageButton ID="ImageButtonGrid" runat="server" CssClass="" ImageUrl="~/images/icon/black/horizontal20.png" OnClick="ImageButtonGrid_Click" Height="40px" Width="40px"   />
             <asp:ImageButton ID="ImageButtonList" runat="server" CssClass="" ImageUrl="~/images/icon/black/six15.png" OnClick="ImageButtonList_Click" Height="40px" Width="40px"   />
            
             
           <asp:ImageButton ID="btnChangeBackground" OnClientClick="$('html').css('overflow', 'hidden');" Visible="false" runat="server" Height="40" Width="40" Text="Change Background" ImageUrl="~/images/icon/black/photo146.png"  />

      <asp:Panel ID="pnChangeBackground" runat="server" CssClass="popup2" Style="display:none;">
         
                Choose Your Background:<br />
              
          <ajaxToolkit:AjaxFileUpload ID="AjaxFileUpload1" runat="server" OnUploadComplete="AjaxFileUpload1_UploadComplete" 

OnClientUploadComplete="OnClientUploadComplete" MaximumNumberOfFiles="1" AllowedFileTypes="jpg,jpeg,tiff,png,gif"/>

        <asp:Button ID="btnbckcancel" runat="server" Text="Cancel" />
            
        </asp:Panel>
        <ajaxToolkit:ModalPopupExtender OnOkScript="$('html').css('overflow', 'auto');" OnCancelScript="$('html').css('overflow', 'auto');" ID="ModalPopupExtender2" runat="server" PopupControlID="pnChangeBackground" 

TargetControlID="btnChangeBackground"                                      
             DropShadow="true" BackgroundCssClass="modalBackground" CancelControlID="btnbckcancel"
             Drag="false">
        </ajaxToolkit:ModalPopupExtender>
             
             
              </div>
      <div class="clearfix colelem side_menu"><!-- group -->
          <asp:UpdatePanel ID="UpdatePanel3" runat="server" Visible="false">
              <ContentTemplate>
                  <div id="robota_group" style="margin-top: 25px;margin-left: 15px;">
              <input id='inputbox' onclick="Enablemeagain();" placeholder="Ask Robota" onfocus="this.placeholder=''" onblur="this.placeholder='Ask Robota'" name="question" type="text" style="width: 130px; border-width: 1px;padding: 2px;margin-left: -12px;border-top-left-radius: 5px;border-bottom-left-radius: 5px;"/>
              <input id="btn" onclick="GetAnswer(); this.disabled = true; return false;" type="submit" value="Ask" style="margin-left: -4px;border: 1px solid black; padding:2px;border-top-right-radius: 5px;background-color: #26284f;color: white;border-bottom-right-radius: 5px;" /><br />
              <img height="100" width="100" src="images/robota.png" style="margin-left: 20px;"/>
  <div class="arrow-up"></div>
     <input id="answer" style="width:160px;padding: 2px;border-width: 1px;border-radius: 5px;margin-left: -12px;" type="text" /> <br /><br />
             </div>
              </ContentTemplate>
          </asp:UpdatePanel>
       <div class="clearfix grpelem" id="side_menu_bar"style="margin-top: 5px;margin-left: 5px;";
"><!-- column -->
        <asp:Button ID="btnPost" runat="server" Text="Post" CssClass="sidecatmenu"  />
          <asp:Button ID="btnVideo" runat="server" Text="Video" CssClass="sidecatmenu"  />
          <asp:Button ID="btnPhoto" runat="server" Text="Photo" CssClass="sidecatmenu" OnClick="btnPhoto_Click"  />
          <asp:Button ID="btnFriend" runat="server" Text="Friend" CssClass="sidecatmenu" OnClick="btnFriend_Click" />
          <asp:Button ID="btnAbout" runat="server" Text="About" CssClass="sidecatmenu"  />
          
       </div>

       
      </div>
     </div>
                </div>
                <div class="pinned-colelem" id="chat_bar">
                    <!-- simple frame -->
                </div>
            </div>
        </div>
    </div>
</asp:Content>

