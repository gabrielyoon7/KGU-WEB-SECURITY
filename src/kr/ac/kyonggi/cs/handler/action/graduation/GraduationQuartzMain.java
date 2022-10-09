package kr.ac.kyonggi.cs.handler.action.graduation;

import static org.quartz.JobBuilder.newJob;
import static org.quartz.TriggerBuilder.*;
import static org.quartz.SimpleScheduleBuilder.*;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.SchedulerFactory;
import org.quartz.Trigger;
import org.quartz.impl.StdSchedulerFactory;

import kr.ac.kyonggi.cs.handler.dao.graduation.GraduationTestDAO;
import kr.ac.kyonggi.cs.handler.dto.graduation.GraduationScheduleDTO;

@WebListener
public class GraduationQuartzMain implements ServletContextListener{

   private static GraduationQuartzMain gqm = null;

   public static GraduationQuartzMain getInstance() {
      if (gqm == null) {
         return new GraduationQuartzMain();
      } else
         return gqm;
   }

   public  void timeraction(String today)  throws SchedulerException, InterruptedException {
      //시작점
      ArrayList<GraduationScheduleDTO> schedule = GraduationTestDAO.getInstance().getSchedule();
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

      Date starting = schedule.get(1).getStarting_date(); //제안서 시작
      Date suggestend=schedule.get(1).getEnd_date(); //제안서 마감
      Date midstart = schedule.get(2).getStarting_date(); //중간 시작
      Date midend = schedule.get(2).getEnd_date(); //중간 마감
      Date finstart = schedule.get(3).getStarting_date(); //최종 시작
      Date finend = schedule.get(3).getEnd_date(); //최종 마감
      Date etcstart = schedule.get(5).getStarting_date(); //기타 시작
      Date etcend = schedule.get(5).getEnd_date(); //기타 마감

      String suggestStartStr = sdf.format(starting); //제안 시작
      String suggestEndStr = sdf.format(suggestend); //제안 마감
      String midStartStr = sdf.format(midstart); //중간 시작
      String midEndStr = sdf.format(midend); //중간 마감
      String finStartStr = sdf.format(finstart); //최종시작
      String finEndStr = sdf.format(finend); //최종 마감
      String etcStartStr = sdf.format(etcstart); //기타 시작
      String etcEndStr = sdf.format(etcend);  //기타 마감



      // SchedulerFactory sf = new StdSchedulerFactory();
      // Scheduler sd = sf.getScheduler();
      JobDetail jbsuggest = newJob(GraduationQuartzSuggest.class).withIdentity("startrsuggest", "suggest").build(); // identity
      JobDetail jbsuggestend = newJob(GraduationQuartzSuggestEnd.class).withIdentity("endsuggest","suggest").build();
      JobDetail jbInterim = newJob(GraduationQuartzInterim.class).withIdentity("startinterim","interim").build();
      JobDetail jbInterimend = newJob(GraduationQuartzInterimEnd.class).withIdentity("endinterim","interim").build();
      JobDetail jbfinal = newJob(GraduationQuartzFinal.class).withIdentity("startfinal", "fianl").build();
      JobDetail jbfinalend = newJob(GraduationQuartzFinalEnd.class).withIdentity("endfinal", "fianl").build();
      JobDetail jbetc=newJob(GraduationQuartzEtc.class).withIdentity("startetc","etc").build();
      JobDetail jbetcend=newJob(GraduationQuartzEtcEnd.class).withIdentity("endetc","etc").build();

      Trigger tg = newTrigger().withIdentity("suggestTrigger", "suggest").startAt(starting).build();
      Trigger tg1 = newTrigger().withIdentity("suggestEndTrigger","suggest").startAt(suggestend).build();
      Trigger tg2 = newTrigger().withIdentity("interimTrigger","interim").startAt(midstart).build();
      Trigger tg3 = newTrigger().withIdentity("interimEndTrigger","interim").startAt(midend).build();
      Trigger tg4 = newTrigger().withIdentity("finalTrigger","fianl").startAt(finstart).build();
      Trigger tg5 = newTrigger().withIdentity("finalEndTrigger","fianl").startAt(finend).build();
      Trigger tg6 = newTrigger().withIdentity("EtcTrigger","etc").startAt(etcstart).build();
      Trigger tg7 = newTrigger().withIdentity("EtcEndTrigger","etc").startAt(etcend).build();

      Scheduler scheduler = StdSchedulerFactory.getDefaultScheduler();


      scheduler.start();

      //마감점
      //제안서 시작
      if(suggestStartStr.compareTo(today)>0) {
         scheduler.scheduleJob(jbsuggest, tg);
      }
      //제안서 마감
      if(suggestEndStr.compareTo(today)>0) {
         scheduler.scheduleJob(jbsuggestend, tg1);
      }
      //중간 시작
      if(midStartStr.compareTo(today)>0) {
         scheduler.scheduleJob(jbInterim, tg2);
      }
      //중간 마감
      if(midEndStr.compareTo(today)>0) {
         scheduler.scheduleJob(jbInterimend, tg3);
      }
      //최종 시작
      if(finStartStr.compareTo(today)>0) {
         scheduler.scheduleJob(jbfinal, tg4);
      }
      //최종 마감
      if(finEndStr.compareTo(today)>0) {
         scheduler.scheduleJob(jbfinalend, tg5);
      }
      //기타시작
      if(etcStartStr.compareTo(today)>0) {
         scheduler.scheduleJob(jbetc, tg6);
      }
      //기타 마감
      if(etcEndStr.compareTo(today)>0) {
         scheduler.scheduleJob(jbetcend, tg7);
      }


   }


   public void offTimer(){
      try{
         Scheduler scheduler = StdSchedulerFactory.getDefaultScheduler();
         scheduler.shutdown();
      }catch (Exception e){
         e.printStackTrace();
      }
   }

   //이부분은 war이 서버로 올라 갈때만 실행
   @Override
   public void contextInitialized(ServletContextEvent arg0) {
      /*try {
         Date today = new Date();
         String str = new SimpleDateFormat("yyyy-MM-dd").format(today);
         GraduationQuartzMain.getInstance().timeraction(str);
      }catch(Exception e) {
         e.printStackTrace();
      }*/
   }

   @Override
   public void contextDestroyed(ServletContextEvent arg0) {
      System.out.println("init destory"); // Destory와 동시에 실행되는 부분
   }


}