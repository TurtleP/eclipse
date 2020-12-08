from setuptools import setup, find_packages

with open('README.md', 'r', encoding='utf-8') as f:
    readme = f.read()

with open('eclipse/__init__.py', 'r', encoding='utf-8') as f:
    for line in f:
        if line.startswith('__version__'):
            version = eval(line.split('=')[1])

setup(
    name='eclipse',
    version=version,
    author='TurtleP',
    author_email='jpostelnek@outlook.com',
    license='MIT',
    url='https://github.com/TurtleP/eclipse',
    python_requires='>=3.8.0',
    description='"MoonScript & LÖVE Helper"',
    long_description=readme,
    long_description_content_type='text/markdown',
    install_requires=[],
    packages=find_packages(),
    package_data={},
    entry_points={'console_scripts': ['eclipse=eclipse.__main__:main']},
    classifiers=[
        'Programming Language :: Python :: 3',
        'License :: OSI Approved :: MIT License',
        'Operating System :: POSIX :: Linux'
    ]
)
