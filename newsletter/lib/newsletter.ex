defmodule Newsletter do
  def read_emails(path) do
    {:ok, file} = File.read(path)
    File.close(file)
    String.split(file, "\n", trim: true)
  end

  def open_log(path) do
    File.open!(path, [:write])
  end

  def log_sent_email(pid, email) do
    IO.puts(pid, email)
  end

  def close_log(pid) do
    File.close(pid)
  end

  def send_newsletter(emails_path, log_path, send_fun) do
    emails = Newsletter.read_emails(emails_path)

    log_pid = Newsletter.open_log(log_path)

    Enum.each(emails, fn email -> 
      case send_fun.(email) do
      :ok -> Newsletter.log_sent_email(log_pid, email)
      _ -> :error
      end
    end)

    Newsletter.close_log(log_pid)
  end
end
