class Comments{
	constructor(comments_id, cwriter, msg)	{
		this.str="";
		this.str+="<div class=\"reply\">";
		this.str+="<div id=\"cwriter\">"+cwriter+"</div>";
		this.str+="<div id=\"msg\">"+msg+"</div>";
		this.str+="</div>";
	}
	getStr(){
		return this.str;
	}
}