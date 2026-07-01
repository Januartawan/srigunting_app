import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/button/button.dart';
import 'package:srigunting_app/src/infrastructure/components/atoms/image/image_svg.dart';
import 'package:srigunting_app/src/infrastructure/components/molecules/layout/scaffold.dart';
import 'package:srigunting_app/src/infrastructure/decoration/button_style.dart';
import 'package:srigunting_app/src/infrastructure/decoration/text_style.dart';
import 'package:srigunting_app/src/infrastructure/theme/colors.dart';
import 'package:url_launcher/url_launcher.dart';
class ContactUsScreen extends StatelessWidget{
  const ContactUsScreen({super.key});
  static const String _contactName='Bali Bird Park Official';
  static const String _phoneNumberDisplay='+62 811-3883-388';
  static const String _phoneNumberRaw='628113883388';
  static const String _whatsappGreeting='Halo Bali Bird Park, saya ingin bertanya.';
  @override
  Widget build(BuildContext context){
    return SScaffold(
      title:'Hubungi Kami',
      onBackAction:()=>Navigator.pop(context),
      body:SingleChildScrollView(
        physics:const BouncingScrollPhysics(),
        child:Column(
          crossAxisAlignment:CrossAxisAlignment.stretch,
          children:[
            const SizedBox(height:8),
            _ContactCard(
              name:_contactName,
              phone:_phoneNumberDisplay,
              onCopy:()=>_copyNumber(context),
              onCall:()=>_openDialer(context)
            ),
            const SizedBox(height:32),
            _WhatsAppButton(onPressed:()=>_openWhatsApp(context)),
            const SizedBox(height:12),
            SButton(
              textStyle:lightText.copyWith(fontSize:14,fontWeight:FontWeight.w400),
              prefixIcon:const Icon(Icons.arrow_back_rounded,size:14,color:AppColors.textBrandOn),
              label:'Kembali',
              buttonStyle:primaryStyleButton,
              onPressed:()=>Navigator.pop(context)
            ),
            const SizedBox(height:16)
          ]
        )
      )
    );
  }
  Future<void> _openWhatsApp(BuildContext context) async{
    final encodedMessage=Uri.encodeComponent(_whatsappGreeting);
    final waApp=Uri.parse('whatsapp://send?phone=$_phoneNumberRaw&text=$encodedMessage');
    final waWeb=Uri.parse('https://wa.me/$_phoneNumberRaw?text=$encodedMessage');
    try{
      if(await canLaunchUrl(waApp)){
        await launchUrl(waApp,mode:LaunchMode.externalApplication);
        return;
      }
      await launchUrl(waWeb,mode:LaunchMode.externalApplication);
    }catch(_){if(context.mounted){_showSnack(context,'Tidak dapat membuka WhatsApp');}}
  }
  Future<void> _openDialer(BuildContext context) async{
    final uri=Uri(scheme:'tel',path:'+$_phoneNumberRaw');
    try{await launchUrl(uri);}
    catch(_){if(context.mounted){_showSnack(context,'Tidak dapat membuka aplikasi telepon');}}
  }
  Future<void> _copyNumber(BuildContext context) async{
    await Clipboard.setData(const ClipboardData(text:_phoneNumberDisplay));
    if(context.mounted){_showSnack(context,'Nomor disalin');}
  }
  void _showSnack(BuildContext context,String message){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:Text(message),
        behavior:SnackBarBehavior.floating,
        duration:const Duration(seconds:2)
      )
    );
  }
}
class _ContactCard extends StatelessWidget{
  final String name;
  final String phone;
  final VoidCallback onCopy;
  final VoidCallback onCall;
  const _ContactCard({required this.name,required this.phone,required this.onCopy,required this.onCall});
  @override
  Widget build(BuildContext context){
    return Container(
      padding:const EdgeInsets.all(20),
      decoration:BoxDecoration(
        color:AppColors.bgBasePrimary,
        borderRadius:BorderRadius.circular(24),
        border:Border.all(color:AppColors.borderBasePrimary),
        boxShadow:[BoxShadow(color:Colors.black.withAlpha(13),blurRadius:16,offset:const Offset(0,4))]
      ),
      child:Column(children:[
        Container(
          width:72,
          height:72,
          padding:const EdgeInsets.all(12),
          decoration:const BoxDecoration(shape:BoxShape.circle,color:AppColors.bgDisabledPrimary),
          alignment:Alignment.center,
          child:const SImageSvgAsset(fileName:'bali_bird_park_mark.svg')
        ),
        const SizedBox(height:16),
        Text(name,textAlign:TextAlign.center,style:darkText.copyWith(fontSize:18,fontWeight:FontWeight.w700)),
        const SizedBox(height:6),
        Text('Customer Service',style:darkText.copyWith(fontSize:13,fontWeight:FontWeight.w400,color:AppColors.textBaseSecondary)),
        const SizedBox(height:18),
        Container(
          padding:const EdgeInsets.symmetric(horizontal:16,vertical:14),
          decoration:BoxDecoration(color:AppColors.bgBaseSecondary,borderRadius:BorderRadius.circular(16)),
          child:Row(children:[
            const Icon(Icons.phone_outlined,size:20,color:AppColors.iconBrandPrimary),
            const SizedBox(width:12),
            Expanded(child:Text(phone,style:darkText.copyWith(fontSize:15,fontWeight:FontWeight.w600,letterSpacing:0.2))),
            _CircleIconAction(icon:Icons.copy_rounded,tooltip:'Salin nomor',onTap:onCopy),
            const SizedBox(width:8),
            _CircleIconAction(icon:Icons.call_rounded,tooltip:'Telepon',onTap:onCall)
          ])
        )
      ])
    );
  }
}
class _CircleIconAction extends StatelessWidget{
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;
  const _CircleIconAction({required this.icon,required this.tooltip,required this.onTap});
  @override
  Widget build(BuildContext context){
    return Material(
      color:AppColors.bgBasePrimary,
      shape:const CircleBorder(),
      child:InkWell(
        onTap:onTap,
        customBorder:const CircleBorder(),
        child:Tooltip(message:tooltip,child:SizedBox(width:36,height:36,child:Icon(icon,size:18,color:AppColors.iconBrandPrimary)))
      )
    );
  }
}
class _WhatsAppButton extends StatelessWidget{
  final VoidCallback onPressed;
  const _WhatsAppButton({required this.onPressed});
  static const Color _waGreen=Color(0xFF25D366);
  @override
  Widget build(BuildContext context){
    return Material(
      color:_waGreen,
      borderRadius:BorderRadius.circular(40),
      elevation:0,
      child:InkWell(
        onTap:onPressed,
        borderRadius:BorderRadius.circular(40),
        child:Container(
          height:56,
          alignment:Alignment.center,
          padding:const EdgeInsets.symmetric(horizontal:24),
          child:Row(
            mainAxisAlignment:MainAxisAlignment.center,
            children:[
              const SImageSvgAsset(fileName:'icon_whatsapp.svg',height:22,width:22,colorFilter:ColorFilter.mode(Colors.white,BlendMode.srcIn)),
              const SizedBox(width:10),
              Text('Chat di WhatsApp',style: lightText.copyWith(fontSize:16,fontWeight:FontWeight.w700))
            ]
          )
        )
      )
    );
  }
}