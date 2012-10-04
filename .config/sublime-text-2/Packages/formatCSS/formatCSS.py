import sublime, sublime_plugin

class ExampleCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        self.view.insert(edit, 1, "Hello, World!")
        sulime.status_message('h2ero')