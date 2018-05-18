package com.song.blogsupport.utils;

import com.jcraft.jsch.Session;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.eclipse.jgit.api.Git;
import org.eclipse.jgit.api.PullCommand;
import org.eclipse.jgit.api.PushCommand;
import org.eclipse.jgit.api.TransportConfigCallback;
import org.eclipse.jgit.api.errors.GitAPIException;
import org.eclipse.jgit.lib.Repository;
import org.eclipse.jgit.storage.file.FileRepositoryBuilder;
import org.eclipse.jgit.transport.*;

import java.io.File;
import java.io.IOException;
import java.util.Date;

/**
 * Created by 00013708 on 2017/6/14.
 */
@Slf4j
public class GitUtil {
    private static Git git = null;

    public static void commitBySSHKey(String gitRepositoryPath, String comment){
        SshSessionFactory factory = new JschConfigSessionFactory() {
            @Override
            protected void configure(OpenSshConfig.Host hc, Session session) {
            }
        };
        TransportConfigCallback transportConfigCallback = new TransportConfigCallback() {
            @Override
            public void configure(Transport transport) {
                SshTransport sshTransport = (SshTransport)transport;
                sshTransport.setSshSessionFactory(factory);
            }
        };
        Git git = null;
        try {
            Repository existingRepo = new FileRepositoryBuilder()
                    .setGitDir(new File(gitRepositoryPath + "/.git"))
                    .build();
            git = new Git(existingRepo);

            PullCommand pullCommand = git.pull();
            pullCommand.setTransportConfigCallback(transportConfigCallback);
            pullCommand.call();
            //true if no differences exist between the working-tree, the index, and the current HEAD, false if differences do exist
            if (git.status().call().isClean() == true) {
                log.info("\n-------code is clean------");
                System.out.println("\n-------code is clean------");
            } else {  //clean
                git.add().addFilepattern(".").call();

                String timeSuffix = DateFormatUtils.format(new Date(), "yyyy-MM-dd");

                git.commit().setMessage(timeSuffix + " " + comment).call();
                PushCommand pushCommand = git.push();
                pushCommand.setTransportConfigCallback(transportConfigCallback);
                pushCommand.call();
                log.info("------succeed add,commit,push files . to repository at "
                        + existingRepo.getDirectory());
            }
        } catch (IOException e) {
            log.error(e.getMessage(), e);
        } catch (GitAPIException e) {
            log.error(e.getMessage(), e);
        } finally {
            if (git != null) {
                git.close();
            }
        }
    }

    public static void commitByPwd(String gitRepositoryPath, String comment) {
        Git git = null;
        try {
            Repository existingRepo = new FileRepositoryBuilder()
                    .setGitDir(new File(gitRepositoryPath + "/.git"))
                    .build();
            git = new Git(existingRepo);
            CredentialsProvider cp = null;
            git.pull().setCredentialsProvider(cp);

            //true if no differences exist between the working-tree, the index, and the current HEAD, false if differences do exist
            if (git.status().call().isClean() == true) {
                log.info("\n-------code is clean------");
                System.out.println("\n-------code is clean------");
            } else {  //clean
                git.add().addFilepattern(".").call();

                String timeSuffix = DateFormatUtils.format(new Date(), "yyyy-MM-dd");

                git.commit().setMessage(timeSuffix + " " + comment).call();
                git.push().setCredentialsProvider(cp).call();
                log.info("------succeed add,commit,push files . to repository at "
                        + existingRepo.getDirectory());
            }
        } catch (IOException e) {
            log.error(e.getMessage(), e);
        } catch (GitAPIException e) {
            log.error(e.getMessage(), e);
        } finally {
            if (git != null) {
                git.close();
            }
        }
    }
}
