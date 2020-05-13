package com.example.goStudy;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ExpandableListView;
import android.widget.ProgressBar;
import android.widget.Spinner;

import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;

import java.util.ArrayList;
import java.util.Timer;
import java.util.TimerTask;


public class ProgressFragment extends Fragment {

    ProgressBar weeklypb;
    int wpbCounter =0;
    ProgressBar semesterpb;
    int spbCounter = 0;
    ExpandableListView expandableListView;

    public View onCreateView(@NonNull LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View root = inflater.inflate(R.layout.fragment_progress, container, false);

        //create spinner courses
        Spinner coursesSpinner = root.findViewById(R.id.spr_progressCourses);
        ArrayList<String> coursesList = new ArrayList<>();
        coursesList.add(0, "All courses");
        coursesList.add("Algorithms");
        coursesList.add("Linear algebra 1");
        coursesList.add("Linear algebra 2");
        coursesList.add("Introduction into computer science");
        coursesList.add("Hedva 1");
        coursesList.add("Hedva 2");
        coursesList.add("Software project");
        ArrayAdapter<String> arrayAdapter_courses = new ArrayAdapter<String>(this.getActivity(), android.R.layout.simple_spinner_item, coursesList);
        arrayAdapter_courses.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        coursesSpinner.setAdapter(arrayAdapter_courses);

        // weekly progress bar
        final Timer timerWeekly;
        TimerTask timerTaskWeekly;
        weeklypb = root.findViewById(R.id.weeklyProgressBar);
        timerWeekly = new Timer();
        timerTaskWeekly = new TimerTask() {
            @Override
            public void run() {
                wpbCounter++;
                weeklypb.setProgress(wpbCounter);

                if(wpbCounter == 40)
                    timerWeekly.cancel();
            }
        };
        timerWeekly.schedule(timerTaskWeekly,0,50);


        //semester progress bar
        final Timer timerSemester;
        TimerTask timerTaskSemester;
        semesterpb = root.findViewById(R.id.semesterProgressBar);
        timerSemester = new Timer();
        timerTaskSemester = new TimerTask() {
            @Override
            public void run() {
                spbCounter++;
                semesterpb.setProgress(spbCounter);

                if(spbCounter == 70)
                    timerSemester.cancel();
            }
        };
        timerSemester.schedule(timerTaskSemester,0,50);

        //collapse goals list
        expandableListView=root.findViewById(R.id.weeklyGoalsExpand);
        ExpandableTextViewAdapter adapter = new ExpandableTextViewAdapter(container.getContext());
        expandableListView.setAdapter(adapter);
        return root;
    }
}

